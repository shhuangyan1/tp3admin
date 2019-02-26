<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/12/26 0026
 * Time: 13:50
 */

namespace Home\Controller;


class KuaiqianpayController
{
    /*当日和逾期扣款
     * */
    public function daikoupay()
    {
        //快钱支付
        $merchantId = M('sys_inteparameter')->where(array('ParaName' => 'kq_merchantId'))->getField('ParaValue');//商户号
        $loginKey = M('sys_inteparameter')->where(array('ParaName' => 'kq_loginKey'))->getField('ParaValue');//商户秘钥
        $terminalId = M('sys_inteparameter')->where(array('ParaName' => 'kq_terminalId'))->getField('ParaValue');//商户终端号
        //获取短信模板sys_smstemplates
        $smshkcg = M('sys_smstemplates')->where(array('EName' => 'huankuanchenggong', 'Status' => '1', 'IsDel' => '0'))->getField('Content');//还款成功
        $smsyqhkcg = M('sys_smstemplates')->where(array('EName' => 'yqhkcg', 'Status' => '1', 'IsDel' => '0'))->getField('Content');//逾期还款成功

        $hkEndTime = date("Y-m-d", strtotime("+1 day"));
        $where['YyFkTime'] = array('elt', $hkEndTime);
        $where['LoanStatus'] = '2';
        $find = M('loans_applylist')->where($where)->select();

        foreach ($find as $applydata) {
            $renzen_bank = M('renzen_bank')->where(array('UserID' => $applydata['UserID']))->find();//银行卡认证信息
            $mem_info = M('mem_info')->where(array('ID' => $applydata['UserID']))->find();//会员信息

            //过了当天夜里24点才算逾期
            $overtimes = date('Y-m-d', strtotime($applydata['YyFkTime'])) . ' 23:59:59';
            if ($overtimes < date('Y-m-d H:i:s')) {
                $apply['IsYQ']='1';
                //已经逾期了
                $yuqidata = getoverinfos($applydata['ID']);
                $hkdata['TotalMoney'] = $yuqidata['realtotal'];//应付总金额
                $hkdata['FinePayable'] = $yuqidata['famoney'];//应还罚金
            } else {
                //未逾期
                $hkdata['TotalMoney'] = $applydata['BackM'];//到期应还
            }
            $yuqidata = getoverinfos($applydata['ID']);
            $realtotal = $yuqidata['realtotal'];//应付金额+罚金
            $famoney = $yuqidata['famoney'];//应还罚金
            $overdays = $yuqidata['overdays'];//逾期天数
            $data['amount'] = $realtotal;//金额
            $data['externalRefNumber'] = $applydata['OrderSn'];//订单号
            $data['cardHolderName'] = $mem_info['TrueName'];//持卡人姓名
            $data['cardHolderId'] = $mem_info['IDCard'];//持卡人身份证号
            $data['BankNo'] = $renzen_bank['BankNo'];//银行卡号
            $data['BankName'] = $renzen_bank['BankName'];//银行名称
            $data['OpenBankName'] = $renzen_bank['OpenBankName'];//开户支行名称
            $data['Mobile'] = $renzen_bank['YMobile'];//手机号
            $data['merchantId'] = $merchantId;//商户号
            $data['loginKey'] = $loginKey;//key
            $data['terminalId'] = $terminalId;//商户终端号

            //      调用快钱协议支付
            $Kuaiqian = new \Kuaiqian\Kuaiqian;
            $res = $Kuaiqian->collectkuaiqian($data);
            if ($res['status'] == 1) {//银行卡还款成功
                $apply = array(
                    'LoanStatus' => '3'
                );
                M('loans_applylist')->where(array('ID' => $applydata['ID']))->save($apply);//更改订单状态  为已经完成
                $hkdata = array(
                    'UserID' => $applydata['UserID'],
                    'ApplyID' => $applydata['ID'],
                    'OrderSn' => date(ymd) . rand(1, 9) . date(His) . rand(111, 999),
                    'LoanNo' => $applydata['LoanNo'],
                    'HkTime' => date('Y-m-d H:i:s'),
                    'CostPayable' => $applydata['ApplyMoney'] - $applydata['CoMoney'],//本金-优惠券
                    'RatePayable' => $applydata['Interest'],//利息
                    'PayType' => '3',//支付类型 0未付款 1支付宝 2微信 3银联 4线下还款
                    'PayStatus' => '1',// 0待支付 1已支付
                    'Status' => '1' // 0待审核 1审核成功 2审核失败
                );
                M('loans_hklist')->add($hkdata);//创建还款订单

                $msg = null;
                $date = date_create($applydata['ApplyTime']);
                $time = date_format($date, "Y-m-d");
                if ($famoney < 1) {
                    $msg = str_replace("#name#", $mem_info['TrueName'], $smshkcg);
                    $msg = str_replace("#time#", $time, $msg);
                    $msg = str_replace("#money#", $applydata['BackM'], $msg);
                } else {
                    $msg = str_replace("#name#", $mem_info['TrueName'], $smsyqhkcg);
                    $msg = str_replace("#time#", $time, $msg);
                    $msg = str_replace("#money#", $applydata['BackM'], $msg);
                    $msg = str_replace("#wymoney#", $famoney, $msg);
                }
                $mobile = $renzen_bank['YMobile'];
                $result = send_message($mobile, $msg);
                if ($result['result'] == 'success') {
                    $data = array("ObjectID" => $mobile, "Type" => 1, "Mode" => 1, "SendMess" => $msg, "Status" => 1, "SendTime" => date("Y-m-d H:i:s"), "Obj" => 2);
                    M('sys_sms')->add($data);
                } else {
                    $data = array("ObjectID" => $mobile, "Type" => 1, "Mode" => 1, "SendMess" => $msg, "Status" => 0, "SendTime" => date("Y-m-d H:i:s"), "Obj" => 2);
                    M('sys_sms')->add($data);
                }
            }
        }
    }

    /*当日首次扣款，发送扣款失败短信
     */
    public function shoucidaikoupay()
    {
        //快钱支付
        $merchantId = M('sys_inteparameter')->where(array('ParaName' => 'kq_merchantId'))->getField('ParaValue');//商户号
        $loginKey = M('sys_inteparameter')->where(array('ParaName' => 'kq_loginKey'))->getField('ParaValue');//商户秘钥
        $terminalId = M('sys_inteparameter')->where(array('ParaName' => 'kq_terminalId'))->getField('ParaValue');//商户终端号
        //获取短信模板sys_smstemplates
        $smshkcg = M('sys_smstemplates')->where(array('EName' => 'huankuanchenggong', 'Status' => '1', 'IsDel' => '0'))->getField('Content');//还款成功
        $smshksb = M('sys_smstemplates')->where(array('EName' => 'hksb', 'Status' => '1', 'IsDel' => '0'))->getField('Content');//还款失败

        $shStartTime = date("Y-m-d");  //按时间查询
        $hkEndTime = date('Y-m-d', strtotime($shStartTime . "+1 day"));
        $where['YyFkTime'] = array('between', $shStartTime . ',' . $hkEndTime);
        $where['LoanStatus'] = '2';
        $find = M('loans_applylist')->where($where)->select();

        foreach ($find as $applydata) {
            $renzen_bank = M('renzen_bank')->where(array('UserID' => $applydata['UserID']))->find();//银行卡认证信息
            $mem_info = M('mem_info')->where(array('ID' => $applydata['UserID']))->find();//会员信息

            $yuqidata = getoverinfos($applydata['ID']);
            $realtotal = $yuqidata['realtotal'];//应付金额+罚金
            $famoney = $yuqidata['famoney'];//应还罚金
            $overdays = $yuqidata['overdays'];//逾期天数
            $data['amount'] = $realtotal;//金额
            $data['externalRefNumber'] = $applydata['OrderSn'];//订单号
            $data['cardHolderName'] = $mem_info['TrueName'];//持卡人姓名
            $data['cardHolderId'] = $mem_info['IDCard'];//持卡人身份证号
            $data['BankNo'] = $renzen_bank['BankNo'];//银行卡号
            $data['BankName'] = $renzen_bank['BankName'];//银行名称
            $data['OpenBankName'] = $renzen_bank['OpenBankName'];//开户支行名称
            $data['Mobile'] = $renzen_bank['YMobile'];//手机号
            $data['merchantId'] = $merchantId;//商户号
            $data['loginKey'] = $loginKey;//key
            $data['terminalId'] = $terminalId;//商户终端号

            //      调用快钱协议支付
            $Kuaiqian = new \Kuaiqian\Kuaiqian;
            $res = $Kuaiqian->collectkuaiqian($data);
            if ($res['status'] == 1) {//银行卡还款成功
                M('loans_applylist')->where(array('ID' => $applydata['ID']))->save(array('LoanStatus' => '3'));//更改订单状态  为已经完成
                $hkdata = array(
                    'UserID' => $applydata['UserID'],
                    'ApplyID' => $applydata['ID'],
                    'OrderSn' => date(ymd) . rand(1, 9) . date(His) . rand(111, 999),
                    'LoanNo' => $applydata['LoanNo'],
                    'HkTime' => date('Y-m-d H:i:s'),
                    'TotalMoney' => $applydata['BackM'],
                    'CostPayable' => $applydata['ApplyMoney'] - $applydata['CoMoney'],//本金-优惠券
                    'RatePayable' => $applydata['Interest'],//利息
                    'PayType' => '3',//支付类型 0未付款 1支付宝 2微信 3银联 4线下还款
                    'PayStatus' => '1',// 0待支付 1已支付
                    'Status' => '1' // 0待审核 1审核成功 2审核失败
                );
                M('loans_hklist')->add($hkdata);//创建还款订单

                $date = date_create($applydata['ApplyTime']);
                $time = date_format($date, "Y-m-d");
                $msg = str_replace("#name#", $mem_info['TrueName'], $smshkcg);
                $msg = str_replace("#time#", $time, $msg);
                $msg = str_replace("#money#", $applydata['BackM'], $msg);

                $mobile = $renzen_bank['YMobile'];
                $result = send_message($mobile, $msg);
                if ($result['result'] == 'success') {
                    $data = array("ObjectID" => $mobile, "Type" => 1, "Mode" => 1, "SendMess" => $msg, "Status" => 1, "SendTime" => date("Y-m-d H:i:s"), "Obj" => 2);
                    M('sys_sms')->add($data);
                } else {
                    $data = array("ObjectID" => $mobile, "Type" => 1, "Mode" => 1, "SendMess" => $msg, "Status" => 0, "SendTime" => date("Y-m-d H:i:s"), "Obj" => 2);
                    M('sys_sms')->add($data);
                }
            } else {
                $date = date_create($applydata['ApplyTime']);
                $time = date_format($date, "Y-m-d");
                $msg = str_replace("#name#", $mem_info['TrueName'], $smshksb);
                $msg = str_replace("#time#", $time, $msg);

                $mobile = $renzen_bank['YMobile'];
                $result = send_message($mobile, $msg);
                if ($result['result'] == 'success') {
                    $data = array("ObjectID" => $mobile, "Type" => 1, "Mode" => 1, "SendMess" => $msg, "Status" => 1, "SendTime" => date("Y-m-d H:i:s"), "Obj" => 2);
                    M('sys_sms')->add($data);
                } else {
                    $data = array("ObjectID" => $mobile, "Type" => 1, "Mode" => 1, "SendMess" => $msg, "Status" => 0, "SendTime" => date("Y-m-d H:i:s"), "Obj" => 2);
                    M('sys_sms')->add($data);
                }
            }
        }
    }

    /*代付回调
    */
    public function daifureturn()
    {
        $requestBody = @file_get_contents("php://input");
//        $mydata=json_decode($requestBody,1);
        libxml_disable_entity_loader(true);//curl返回的数据.在页面中展示是不会显示xml标签的.会将标签变成实体字符.这一行代表的是禁止变成实体字符
        $xml = simplexml_load_string($requestBody);
        $val = json_decode(json_encode($xml), true);

        $myfile = fopen("daifuhuidiao.txt", "a+") or die("Unable to open file!");
        fwrite($myfile,date('Y-m-d h:i:s',time()).' ');
        fwrite($myfile,$val.' ');//返回数据
        fclose($myfile);


    }
}