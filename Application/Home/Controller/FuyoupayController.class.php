<?php
/**
 * 功能说明: 富友支付回调处理
 */
namespace Home\Controller;
class FuyoupayController extends HomeController{

    public function _initialize(){
        parent::_initialize();
        //配置参数
        $setsinfo=M('sys_inteparameter')->where(array('IntegrateID'=>'13'))->select();
        $setArr=array();
        foreach($setsinfo as $k=>$v){
            $setArr[$v['ParaName']]=$v['ParaValue'];
        }
        $this->config = array(
            'mchntCd' => $setArr['mchntCd'],    //商户代码
            'key' => $setArr['key'],    //商户密钥
        );
    }

    //还款支付回调地址
    public function hkquery(){
       // $data = file_get_contents("php://input");
    	$data =$_REQUEST;
        // $abcs=$_REQUEST;
        // if(!file_exists("hlibao66666.txt")){ $fp = fopen("hlibao66666.txt","wb"); fclose($fp);  }
        //    $str = file_get_contents('hlibao66666.txt');
        //    foreach($abcs as $k=>$v){
        //      $str .= " -  - ".$k.":".$v;
        //    }
        //    $str .= " -  -  -  - ".date("Y-m-d H:i:s")."\r\n";
        //    $fp = fopen("hlibao66666.txt","wb");
        //    fwrite($fp,$str);
        //    fclose($fp);
        //验签操作
//      $result=$this->checksign($data);
//      if ($result){
//          if($data['RESPONSECODE']== "0000"){
//              $order = M('loans_hklist')->field('ID,PayStatus')->where(array('OrderSn'=>$data['MCHNTORDERID']))->find();
//              if($order['PayStatus']=='0'){
//                  $result =$this->change_hkorder_data($data['MCHNTORDERID'],$data['ORDERID']);
//              }
//          }
//      }
//      echo "success";
    }
    //续借支付回调地址
    public function xjquery(){
        //$data = file_get_contents("php://input");
        $data =$_REQUEST;
        //验签操作
        $result=$this->checksign($data);

        if ($result){
            if($data['RESPONSECODE']== "0000"){
                $order = M('loans_xjapplylist')->field('ID,PayStatus')->where(array('OrderSn'=>$data['MCHNTORDERID']))->find();
                if($order['PayStatus']=='0'){
                    $result =$this->change_xjorder_data($data['MCHNTORDERID'],$data['ORDERID']);
                }
            }
        }
        echo "success";
    }
    

    //根据订单号修改还款记录 
    public function change_hkorder_data($out_trade_no,$trade_no){
        $dailinfos=M('loans_hklist')->field('ID,ApplyID,UserID,OrderSn,LoanNo,TotalMoney,PayType')->where(array('OrderSn'=>$out_trade_no))->find();
        //$mem_info=M('mem_info')->where(array('ID'=>$dailinfos['UserID']))->find();

        $Trans = M();
        $Trans->startTrans();
        $dl_data=array(
            'TradeNo'=>$trade_no,
            'PayStatus'=>'1',
            'PayTime'=>date('Y-m-d H:i:s'),
            'ShTime'=>date('Y-m-d H:i:s'),
            'Status'=>'1',
            );
        $flag1 = $Trans->table('xb_loans_hklist')->where(array('OrderSn'=>$out_trade_no))->save($dl_data);//如果成功，则就更新 xb_loans_applylist 为已还款了
        if($flag1){
            $applyrest=$Trans->table('xb_loans_applylist')->where(array('ID'=>$dailinfos['ApplyID']))->save(array('LoanStatus'=>'3'));
            if($applyrest){
                //添加 支付记录
                $content ='支付成功,订单号 '.$out_trade_no.'，支付价格￥'.$dailinfos['TotalMoney'].'元';
                send_mem_notics($dailinfos['UserID'],$content);//发送站内消息
                $recoddata=array(
                    'UserID'=>$dailinfos['UserID'],
                    'OrderSn'=>$dailinfos['OrderSn'],
                    'LoanNo'=>$dailinfos['LoanNo'],
                    'TradeNo'=>$trade_no,
                    'TradeType'=>'2',
                    'OrderAmount'=>$dailinfos['TotalMoney'],
                    'PayType'=>$dailinfos['PayType'],
                    'PayStatus'=>'1',
                    'Description'=>$content,
                    );
                $flag2 =$Trans->table('xb_loans_paylist')->add($recoddata);
                if($flag2){
                    $Trans->commit();
                    return true;
                }else{
                    $Trans->rollback();
                    return false;
                }
            }else{
                $Trans->rollback();
                return false;
            }
        }else{
            $Trans->rollback();
            return false;
        }
    }
    //根据订单号修改 续借支付 
    public function change_xjorder_data($out_trade_no,$trade_no){
        $dailinfos=M('loans_xjapplylist')->field('ID,UserID,OrderSn,LoanNo,ApplyID,LoanDay,TotalMoney,PayType')->where(array('OrderSn'=>$out_trade_no))->find();
        //$mem_info=M('mem_info')->where(array('ID'=>$dailinfos['UserID']))->find();

        $Trans = M();
        $Trans->startTrans();
        $dl_data=array(
            'TradeNo'=>$trade_no,
            'PayStatus'=>'1',
            'PayTime'=>date('Y-m-d H:i:s'),
            'ShTime'=>date('Y-m-d H:i:s'),
            'Status'=>'1',
            );
        $flag1 = $Trans->table('xb_loans_xjapplylist')->where(array('OrderSn'=>$out_trade_no))->save($dl_data);
        //如果成功，则就更新 xb_loans_applylist 为已还款了
        //并且在重新生成一条续借记录
        if($flag1){
            $applyrest=$Trans->table('xb_loans_applylist')->where(array('ID'=>$dailinfos['ApplyID']))->save(array('LoanStatus'=>'3'));
            if($applyrest){
                $applyinfos=M('loans_applylist')->where(array('ID'=>$dailinfos['ApplyID']))->find();
                //重新添加一条借款记录
                $YyFkTime2=strtotime($applyinfos['YyFkTime'])+$dailinfos['LoanDay']*86400;
                $newdata=array(
                    'UserID'=>$applyinfos['UserID'],
                    'ApplyTime'=>date('Y-m-d H:i:s'),
                    'OrderSn'=>date(ymd).rand(1,9).date(His).rand(111,999),
                    'LoanNo'=>$applyinfos['LoanNo'],
                    'ApplyMoney'=>$applyinfos['ApplyMoney'],
                    'AdoptMoney'=>$applyinfos['AdoptMoney'],
                    'FJMoney'=>$applyinfos['FJMoney'],
                    'Interest'=>$applyinfos['Interest'],
                    'ApplyDay'=>$dailinfos['LoanDay'],
                    'ProductID'=>$applyinfos['ProductID'],
                    'CouponID'=>$applyinfos['CouponID'],
                    'CoMoney'=>$applyinfos['CoMoney'],
                    'OpenM'=>$applyinfos['OpenM'],
                    'BackM'=>$applyinfos['BackM'],
                    'LoanType'=>'1',
                    'LoanStatus'=>'2',
                    'SqAdminID'=>$applyinfos['SqAdminID'],
                    'ServiceID'=>$applyinfos['ServiceID'],
                    'ShTime'=>$applyinfos['ShTime'],
                    'Status'=>$applyinfos['Status'],
                    'RongDay'=>$applyinfos['RongDay'],
                    'RongP'=>$applyinfos['RongP'],
                    'OverdueDay'=>$applyinfos['OverdueDay'],
                    'OverdueP'=>$applyinfos['OverdueP'],
                    'FKadminID'=>$applyinfos['FKadminID'],
                    'FkServiceID'=>$applyinfos['FkServiceID'],
                    'OpenTime'=>date('Y-m-d H:i:s'),
                    'YyFkTime'=>date("Y-m-d H:i:s",$YyFkTime2),
                    );
                $newapply=$Trans->table('xb_loans_applylist')->add($newdata);
                if($newapply){
                    //添加 支付记录
                    $content ='支付成功,订单号 '.$out_trade_no.'，支付价格￥'.$dailinfos['TotalMoney'].'元';
                    send_mem_notics($dailinfos['UserID'],$content);//发送站内消息
                    $recoddata=array(
                        'UserID'=>$dailinfos['UserID'],
                        'OrderSn'=>$dailinfos['OrderSn'],
                        'LoanNo'=>$dailinfos['LoanNo'],
                        'TradeNo'=>$trade_no,
                        'TradeType'=>'1',
                        'OrderAmount'=>$dailinfos['TotalMoney'],
                        'PayType'=>$dailinfos['PayType'],
                        'PayStatus'=>'1',
                        'Description'=>$content,
                        );
                    $flag2 =$Trans->table('xb_loans_paylist')->add($recoddata);
                    if($flag2){
                        $Trans->commit();
                        return true;
                    }else{
                        $Trans->rollback();
                        return false;
                    }
                }else{
                    $Trans->rollback();
                    return false;
                }
            }else{
                $Trans->rollback();
                return false;
            }
        }else{
            $Trans->rollback();
            return false;
        }
    }
    //验证签名操作
    public function checksign($data){
    	$mchntCd=$this->config['mchntCd'];//商户代码
        $key=$this->config['key'];    //商户密钥

    	$self=$data['TYPE']."|".$data['VERSION']."|".$data['RESPONSECODE']."|".$data['MCHNTCD']."|".$data['MCHNTORDERID']."|".$data['ORDERID']."|".$data['AMT']."|".$data['BANKCARD']."|".$key;
    	if(md5($self)==$data['SIGN']){
    		return true;
    	}else{
    		return false;
    	}
    }

}