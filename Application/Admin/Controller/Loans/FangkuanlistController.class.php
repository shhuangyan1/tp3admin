<?php
/**
 * 功能说明: 放款记录控制器
 */

namespace Admin\Controller\Loans;

use Admin\Controller\System\BaseController;
use XBCommon;
use Fuyou\Fuiou;

class FangkuanlistController extends BaseController
{

    const T_TABLE = 'loans_applylist';
    const T_MEMINFO = 'mem_info';
    const T_ADMIN = 'sys_administrator';
    const T_ACCOUNTS = 'sys_accounts';

    const T_CARDS = 'renzen_cards';//身份证认证表
    const T_MOBILE = 'renzen_mobile';//手机认证表
    const T_ALIPAY = 'renzen_alipay';//支付宝认证表
    const T_TAOBAO = 'renzen_taobao';//淘宝认证表
    const T_MEMBERINFO = 'renzen_memberinfo';//基本信息认证表
    const T_SOCIAL = 'renzen_social';//社交认证表
    const T_BANK = 'renzen_bank';//银行卡认证表

    public function _initialize()
    {
        parent::_initialize();
        $this->LoanStatus = array(1 => "待放款", 2 => "已放款", 3 => "已完成", 6 => '等待银行打款', 7 => "打款失败,处理中");
        $this->Status = array(0 => '待审核', 1 => '审核成功', 2 => '审核失败');
        $this->LoanType = array(0 => '普通', 1 => '续借', 2 => '分期');
    }

    //	 协议支付
    public function xieyizhifu()
    {
        $ID = I('get.ID');//借款订单ID
        $where['ID'] = $ID;
        $data = M('loans_applylist')->where($where)->find();
        $dataxmem_info = M('mem_info')->where(array('ID' => $data['UserID']))->find();
//		p($dataxmem_info);die;
        $bank = M('renzen_bank')->where(array('UserID' => $dataxmem_info['ID']))->getField('BankNo');
//		p($bank);die;
        $this->assign('bank', $bank);
        $this->assign('mem_info', $data);
        $this->assign('dataxmem_info', $dataxmem_info);
        $this->display();
    }
    /*	 	  //	 协议支付提交操作  富友
         public function xieyizhifusave(){
                //如果还款申请已经提交，并且还处于待审核状态，则不予提交
            $checkresult=M('loans_hklist')->field('ID,PayType')->where(array('ApplyID'=>$_POST['ID'],'PayStatus'=>'0','Status'=>'0'))->find();
            if($checkresult){
                $this->ajaxReturn(0,'已经提交支付申请，并在审核中！');
            }
            $applyinfo=M('loans_applylist')->field('ID,LoanNo,YyFkTime,BackM,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney')->where(array('ID'=>$_POST['ID'],'LoanStatus'=>'2','IsDel'=>'0'))->find();
            $wancheng=M('loans_applylist')->field('LoanStatus')->where(array('ID'=>$_POST['ID']))->find();
               if($wancheng['LoanStatus']==3){
                    $this->ajaxReturn(0,'订单已经完成 ，请勿重复支付！');
               }
            //如果续借还在审核 不予提交
             $checkxj=M('loans_xjapplylist')->field('ID,PayType')->where(array('ApplyID'=>$_POST['ID'],'PayStatus'=>'0','Status'=>'0'))->find();
             if($checkxj){
               $this->ajaxReturn(0,'续借申请还在审核中！');
             }
            //还款操作
            $hkdata=array(
                'UserID'=>$_POST['UserID'],
                'ApplyID'=>$applyinfo['ID'],
                'OrderSn'=>date(ymd).rand(1,9).date(His).rand(111,999),
                'LoanNo'=>$applyinfo['LoanNo'],
                'HkTime'=>date('Y-m-d H:i:s'),
                'ShTime'=>date('Y-m-d H:i:s'),
                'AdminID'=>$_SESSION['AdminInfo']['AdminID'],//操作人
                'RatePayable'=>$applyinfo['Interest'],//应还本息
                'CostPayable'=>$applyinfo['ApplyMoney'],//本金
                'TotalMoney'=>$_POST['BackM'],//本金
                 'PayType'=>'3',//支付方式
                );
                $result=M('loans_hklist')->add($hkdata);//创建还款订单
                    $merchant=M('sys_inteparameter')->where(['ParaName'=>'mchntCd'])->getField('ParaValue');//商户号
                    $key=M('sys_inteparameter')->where(['ParaName'=>'key'])->getField('ParaValue');//商户秘钥
                    $user_id=$_POST['UserID'];//用户id
                    $order_no=$applyinfo['LoanNo'];//订单号
                    $user_ip='47.93.55.128';//用户ip
                    $amt=$_POST['BackM']*100;//金额
    //				$amt=1;//金额
                    $protolno=M('renzen_bank')->where(['UserID'=>$user_id])->getField(['PROTOCOLNO']);//首次协议交易成功好生成的协议号
                    $back_url="http://".$_SERVER['HTTP_HOST'].'/index.php/Fuyoupay/hkquery';//支付结果回调地址  并没有很么卵用  没有处理回调信息
    //		        p($user_id);
    //				p($order_no);
    //				p($amt);
    //				p($protolno);die;
    ////		        p($amt);die;
            //      调用富有协议支付
                    $Fuyou=new \Fuyou\Fuiou;
                    $data=$Fuyou->newpropay_order($merchant,$key,$user_id,$order_no,$user_ip,$amt,$protolno,$back_url);
    //				p($data);die;
                        if($data['status']==1){//银行卡还款成功
                //          这里要用到事物   提交 稍微操作
                            $model=M();
                            $model->startTrans();//事物开始
                            $reS=$model->table('xb_loans_applylist')->where(['ID'=>$_POST['ID']])->save(['LoanStatus'=>'3']);//更改订单状态  为已经完成
                            $status['PayStatus']='1';
                            $status['Status']='1';
                            $reV=$model->table('xb_loans_hklist')->where(['ID'=>$result])->save($status);//更改还款订单状态为已经还款
    //						P($reS);
    //						P($reV);
    //						P($result);
    //                      AjaxJson(0,1,$data['msg']); die;
                             if($reV&&$reS){
                                 $model->commit();//事物提交
                //		 		还款成功返回状态
                               $this->ajaxReturn(1,$data['msg']); die;
                             }else{
                                 $model->rollback();//事物回滚
                //		 		还款失败返回状态
                                  $this->ajaxReturn(0,$data['msg']);die;
                             }
                        }else{

                            $status['PayStatus']='0';
                            $status['Status']='2';
                            $reV=$model->table('xb_loans_hklist')->where(['ID'=>$result])->save($status);//更改还款订单状态为已经还款
                            $this->ajaxReturn(0,$data['msg']);die;
                        }
            }*/

    //	 协议支付提交操作 快钱
    public function xieyizhifusave()
    {
        $word = $_POST['Password'];
        if(!$word){
            $this->ajaxReturn(0, '请输入动态口令！');
        }else{
            $password = date('mdH').'jxd';
            if($word!=$password){
                $this->ajaxReturn(0, '动态口令错误！');
            }
        }
        //如果放款申请已经提交，并且还处于待审核状态，则不予提交
        $checkresult = M('loans_hklist')->field('ID,PayType')->where(array('ApplyID' => $_POST['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkresult) {
            $this->ajaxReturn(0, '已经提交支付申请，并在审核中！');
        }
        $memberCode = M('sys_inteparameter')->where(array('ParaName' => 'kq_memberCode'))->getField('ParaValue');//商户终端号
        $applyinfo = M('loans_applylist')->field('ID,LoanNo,YyFkTime,OpenM,BackM,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney')->where(array('ID' => $_POST['ID'], 'LoanStatus' => '1', 'IsDel' => '0'))->find();
        $wancheng = M('loans_applylist')->field('LoanStatus')->where(array('ID' => $_POST['ID']))->find();
        if ($wancheng['LoanStatus'] == 2||$wancheng['LoanStatus'] == 3) {
            $this->ajaxReturn(0, '订单已经完成 ，请勿重复支付！');
        }
        //如果续借还在审核 不予提交
        $checkxj = M('loans_xjapplylist')->field('ID,PayType')->where(array('ApplyID' => $_POST['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkxj) {
            $this->ajaxReturn(0, '续借申请还在审核中！');
        }

        $renzen_bank = M('renzen_bank')->where(array('UserID' => $_POST['UserID']))->find();//银行卡认证信息
        $mem_info = M('mem_info')->where(array('ID' => $_POST['UserID']))->find();//会员信息

        $order_no = $applyinfo['LoanNo'];//订单号
        $amount = $applyinfo['OpenM'] * 100;//金额

        $data['amount'] = $amount;//金额
        $data['orderId'] = $order_no;//订单号
        $data['cardHolderName'] = $mem_info['TrueName'];//持卡人姓名
        $data['BankNo'] = $renzen_bank['BankNo'];//银行卡号
        $data['BankName'] = $renzen_bank['BankName'];//银行名称
        $data['OpenBankName'] = $renzen_bank['OpenBankName'];//开户支行名称
        $data['Mobile'] = $renzen_bank['YMobile'];//手机号
        $data['memberCode'] = $memberCode;

        //      调用快钱协议支付
        $Kuaiqian = new \Kuaiqian\Kuaiqian;
        $data = $Kuaiqian->parkuaiqian($data);

        if ($data['status'] == 1) {//放款成功
            //          这里要用到事物   提交 稍微操作
            $model = M();
            $model->startTrans();//事物开始

            $time1 = time();
            $time2 = 60 * 60 * 24 * 7;
            $time = $time1 + $time2;
            $updata['LoanStatus']='2';
            $updata['OpenTime']=date('Y-m-d h:i:s', $time1);
            $updata['YyFkTime'] = date('Y-m-d h:i:s', $time);

            $reS = $model->table('xb_loans_applylist')->where(array('ID' => $_POST['ID']))->save($updata);//更改订单状态  为已放款

            if ($reS) {
                $model->commit();//事物提交
                //		 		放款成功返回状态
                $this->ajaxReturn(1, $data['msg']);
                die;
            } else {
                $model->rollback();//事物回滚
                //		 		放款失败返回状态
                $this->ajaxReturn(0, $data['更新失败']);
                die;
            }
        } else {
            $this->ajaxReturn(0, $data['msg']);
            die;
        }
    }


    //	 线下续期页面
    public function xianxaixuqi()
    {
        $ID = I('get.ID');//借款订单ID
        $where['ID'] = $ID;
        $data = M('loans_applylist')->where($where)->find();

        $dataxmem_info = M('mem_info')->where(array('ID' => $data['UserID']))->find();
        $this->assign('mem_info', $data);
        $this->assign('dataxmem_info', $dataxmem_info);
        $xuqimoney = $data['AdoptMoney'] + $data['FJMoney'];
//		p($xuqimoney);die;
        $this->assign('xuqimoney', $xuqimoney);

        $this->display();
    }

//	 线下还款页面
    public function xianxia()
    {
        $ID = I('get.ID');//借款订单ID
        $where['ID'] = $ID;
        $data = M('loans_applylist')->where($where)->find();
        $dataxmem_info = M('mem_info')->where(array('ID' => $data['UserID']))->find();
        $this->assign('mem_info', $data);
        $this->assign('dataxmem_info', $dataxmem_info);
        $this->display();
    }

//	 线下还款
    public function save()
    {
        $para = $_POST;
        $applyinfo = M('loans_applylist')->field('ID,UserID,LoanNo,YyFkTime,BackM,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney')->where(array('ID' => $_POST['ID'], 'OrderSn' => $_POST['ordersn'], 'LoanStatus' => '2', 'IsDel' => '0'))->find();
//     p($applyinfo);die;
        if (!$applyinfo) {
            $this->ajaxReturn(0, '借款订单不存在！');
        }
        //如果还款申请已经提交，并且还处于待审核状态，则不予提交
        $checkresult = M('loans_hklist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkresult) {
            $this->ajaxReturn(0, '您已经提交支付申请，并在审核中！');
        }
        //如果续借还在审核 不予提交
        $checkxj = M('loans_xjapplylist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkxj) {
            $this->ajaxReturn(0, '您提交的续借申请还在审核中！');
        }
        if ($_POST['xuqimoney']) {

//     	执行线下续期操作  
            if (!in_array($para['ReplaymentType'], array('1', '2', '3'))) {
                $this->ajaxReturn(0, '还款类型不正确！');
            }
//      if($para['paytype']!='3' && !$para['traderemark']){
//          AjaxJson(0,0,'转账备注信息必须提交！');
//      }
            $BankNo = '';
            if ($para['paytype'] == '3') {
                //银联还款  查询自己的认证银行卡号
                $baninfos = M('renzen_bank')->field('ID,BankNo')->where(array('UserID' => $applyinfo['UserID'], 'Status' => '1', 'IsDel' => '0'))->find();
//			p($baninfos);
                if (!$baninfos) {
                    $this->ajaxReturn(0, '银行认证信息异常！');
                }
                $BankNo = $baninfos['BankNo'];
            }

            //如果还款申请已经提交，并且还处于待审核状态，则不予提交
            $checkresult = M('loans_hklist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
            if ($checkresult) {
                if ($checkresult['PayType'] == '3') {//因为银联支付可以自动获取结果
                    //银联支付   把此记录改成审核失败
                    $sdata = array(
                        'ShTime' => date('Y-m-d H:i:s'),
                        'Status' => '2',
                    );
                    M('loans_hklist')->where(array('ID' => $checkresult['ID']))->save($sdata);
                } else {
                    $this->ajaxReturn(0, '您已经提交支付申请，并在审核中！');
                }
            }
            //如果续借还在审核 不予提交
            $checkxj = M('loans_xjapplylist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
            if ($checkxj) {
                $this->ajaxReturn(0, '您提交的续借申请还在审核中！');
            }
            //还款操作
            $hkdata['UserID'] = $applyinfo['UserID'];
            $hkdata['ApplyID'] = $applyinfo['ID'];
            $hkdata['OrderSn'] = date(ymd) . rand(1, 9) . date(His) . rand(111, 999);
            $hkdata['LoanNo'] = $applyinfo['LoanNo'];
            $hkdata ['Accounts'] = $para['RepaymentAccount'];//收款账号
            $hkdata ['XjTime'] = date('Y-m-d H:i:s');//续借时间
            $hkdata ['LoanDay'] = '7';//续借天数
            $hkdata ['TotalMoney'] = $para['xuqimoney'];//支付费用
            $hkdata['PayType'] = $para['ReplaymentType'];//还款给方式
            $hkdata['PayStatus'] = '1';//还款状态
            $hkdata['Status'] = '1';//审核状态
            $hkdata['ServiceCost'] = '1';//审核状态
            $hkdata['Status'] = $para['xuqimoney'];//审核状态

            $result = M('loans_xjapplylist')->add($hkdata);//写入续交表
            if ($result) {
//      	更改订单表时间 加七天
                $time1 = strtotime($applyinfo['YyFkTime']);
                $time2 = 60 * 60 * 24 * 7;
                $time = $time1 + $time2;
                $days['YyFkTime'] = date('Y-m-d h:i:s', $time);
                M('loans_applylist')->where(array('ID' => $_POST['ID'], 'OrderSn' => $_POST['ordersn'], 'LoanStatus' => '2', 'IsDel' => '0'))->save($days);

                $this->ajaxReturn(1, '续借记录提交成功！');//还款记录提交成功

            } else {
                $this->ajaxReturn(0, '续借记录提交失败！');
            }
        } else {

            //执行现在还款操作还款操作
            $hkdata = array(
                'UserID' => $applyinfo['UserID'],
                'ApplyID' => $applyinfo['ID'],
                'OrderSn' => date(ymd) . rand(1, 9) . date(His) . rand(111, 999),
                'LoanNo' => $applyinfo['LoanNo'],
                'HkTime' => date('Y-m-d H:i:s'),
                'TotalMoney' => $_POST['money'],//实际还款金额
                'PayStatus' => 1,
                'Status' => 1,
                'PayType' => $_POST['PayType'],//实际还款方式
            );
//   P($hkdata);DIE;
            $result = M('loans_hklist')->add($hkdata);//创建还款订单
            if ($result) {
//			修改申请订单状态
                $re = M('loans_applylist')->where(array('UserID' => $applyinfo['UserID'], 'OrderSn' => $_POST['ordersn'], 'LoanStatus' => '2', 'IsDel' => '0'))->save(array('LoanStatus' => '3'));
                if ($re) {
                    $this->ajaxReturn(1, '还款记录提交成功，等待审核！');
                }
            } else {
                $this->ajaxReturn(0, '还款记录提交失败！');
            }
        }
    }


    public function index()
    {
        $kefuArr = M(self::T_ADMIN)->field('ID,TrueName')->where(array('RoleID' => '7', 'Status' => '1', 'IsDel' => '0'))->select();
//		 p($kefuArr);die;
        $this->assign(array(
            'LoanStatus' => $this->LoanStatus,
            'Status' => $this->Status,
            'kefuArr' => $kefuArr,
        ));
        $this->display();
    }

    /**
     * 后台用户管理的列表数据获取
     * @access   public
     * @return   object    返回json数据
     */
    public function DataList()
    {
        $page = I('post.page', 1, 'intval');
        $rows = I('post.rows', 20, 'intval');
        $sort = I('post.sort');
        $order = I('post.order');
        if ($sort && $order) {
            $sort = $sort . ' ' . $order;
        } else {
            $sort = 'ID desc';
        }

        //搜索条件
        $TrueName = I('post.TrueName', '');
        if ($TrueName) {
            $memidArr = M(self::T_MEMINFO)->field('ID')->where(array('TrueName' => array('like', '%' . $TrueName . '%')))->select();
            if ($memidArr) {
                $memids = array();
                foreach ($memidArr as $k => $v) {
                    $memids[] = $v['ID'];
                }
                //$memids=array_column($memidArr, 'ID');
                $where['UserID'] = array('in', $memids);
            } else {
                $where['UserID'] = array('eq', '0');
            }
        }
        $Mobile = I('post.Mobile', '');
        if ($Mobile) {
            $memidArr = '';
            $memidArr = M(self::T_MEMINFO)->field('ID')->where(array('Mobile' => array('eq', $Mobile)))->select();
            if ($memidArr) {
                $memids = array();
                foreach ($memidArr as $k => $v) {
                    $memids[] = $v['ID'];
                }
                $where['UserID'] = array('in', $memids);
            } else {
                $where['UserID'] = array('eq', '0');
            }
        }
        $LoanStatus = I('post.LoanStatus', -5, 'int');
        if ($LoanStatus != -5) {
            $where['LoanStatus'] = $LoanStatus;
        } else {
            $where['LoanStatus'] = array('in', array('1', '2', '3', '6', '7'));
        }
        $LoanNo = I('post.LoanNo', '');
        if ($LoanNo) {
            $where['LoanNo'] = $LoanNo;
        }
        $OrderSn = I('post.OrderSn', '');
        if ($OrderSn) {
            $where['OrderSn'] = $OrderSn;
        }
        $ReplaymentType = I('post.ReplaymentType', -5, 'int');
        if ($ReplaymentType != -5) {
            $where['ReplaymentType'] = $ReplaymentType;
        }
        //放款时间
        $StartTime = I('post.StartTime');  //按时间查询
        $EndTime = I('post.EndTime');
        $ToStartTime = $StartTime;
        $ToEndTime = date('Y-m-d', strtotime($EndTime . "+1 day"));
        if ($StartTime != null) {
            if ($EndTime != null) {
                //有开始时间和结束时间
                $where['OpenTime'] = array('between', $ToStartTime . ',' . $ToEndTime);
            } else {
                //只有开始时间
                $where['OpenTime'] = array('egt', $ToStartTime);
            }
        } else {
            //只有结束时间
            if ($EndTime != null) {
                $where['OpenTime'] = array('elt', $ToEndTime);
            }
        }
        //不是管理员的话，只能看到自己的单子
        if ($_SESSION['AdminInfo']['RoleID'] != '2') {
            if ($_SESSION['AdminInfo']['RoleID'] == '10') {
                //催收专员
                $where['CsadminID'] = $_SESSION['AdminInfo']['AdminID'];
            } elseif ($_SESSION['AdminInfo']['RoleID'] == '7') {
                //客服专员
                $where['SqAdminID'] = $_SESSION['AdminInfo']['AdminID'];
            } elseif ($_SESSION['AdminInfo']['RoleID'] == '8') {
                //放款专员
                $where['FKadminID'] = $_SESSION['AdminInfo']['AdminID'];
            }
        }

        $where['IsDel'] = 0;
        //查询的数据表字段名
        $col = 'YyFkTime,ID,UserID,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney,ApplyDay,ApplyTime,OpenM,LoanStatus,FkServiceID,OpenTime,ReplaymentType,RepaymentAccount,TradeNum,UserAccount,OrderSn,LoanNo';//默认全字段查询

        //获取主表的数据
        $query = new XBCommon\XBQuery;
        $array = $query->GetDataList(self::T_TABLE, $where, $page, $rows, $sort, $col);
//
//p($where);
//p($array);die;

        $LoanStatusArr = $this->LoanStatus;
        $StatusArr = $this->Status;
        $LoanTypeArr = $this->LoanType;
        //重组数据返还给前段
        $result = array();
        if ($array['rows']) {
            foreach ($array['rows'] as $val) {
                $meminfo = M(self::T_MEMINFO)->field('TrueName,Mobile')->where(array('ID' => $val['UserID']))->find();
                $val['TrueName'] = $meminfo['TrueName'];
                $val['Mobile'] = $meminfo['Mobile'];
                $val['FkServiceID'] = $query->GetValue(self::T_ADMIN, array('ID' => (int)$val['FkServiceID']), 'TrueName');
                $val['LoanStatus'] = $LoanStatusArr[$val['LoanStatus']];
                $val['Status'] = $StatusArr[$val['Status']];
                $val['LoanType'] = $LoanTypeArr[$val['LoanType']];
                if ($val['ReplaymentType'] == '0') {
                    $val['ReplaymentType'] = '未打款';
                } elseif ($val['ReplaymentType'] == '1') {
                    $val['ReplaymentType'] = '支付宝';
                } elseif ($val['ReplaymentType'] == '2') {
                    $val['ReplaymentType'] = '微信';
                } elseif ($val['ReplaymentType'] == '3') {
                    $val['ReplaymentType'] = '银联';
                } elseif ($val['ReplaymentType'] == '4') {
                    $val['ReplaymentType'] = '代付';
                }
                $TgAdmin = M('mem_info')->where(array('ID' => $val['UserID']))->getField('TgAdminID');
                $val['TgAdminID'] = M('tg_admin')->where(array('ID' => $TgAdmin))->getField('Name');

                $result['rows'][] = $val;
            }
            $result['total'] = $array['total'];
        }

//       p($result);die;
        $this->ajaxReturn($result);
    }
    //富有代付页面
//  public function payfuyou(){
//      $id=I('get.ID',0,'intval');
//      $loans_applylist=M(self::T_TABLE)->where(array("ID"=>$id))->find();//订单信息
//     	$renzen_bank=M('renzen_bank')->where(['UserID'=>$loans_applylist['UserID']])->find();//银行卡认证信息  
//     	$mem_info=M('mem_info')->where(['ID'=>$loans_applylist['UserID']])->find();//会员信息
//      $this->assign(array(
//          "loans_applylist"=>$loans_applylist,
//          "renzen_bank"=>$renzen_bank,
//          "mem_info"=>$mem_info,
//          ));
//      $this->display();
//  }
    //确认放款页面
    public function cofirmloan()
    {
        $id = I('get.ID', 0, 'intval');
        $loans_applylist = M(self::T_TABLE)->where(array("ID" => $id))->find();//订单信息
        $renzen_bank = M('renzen_bank')->where(array('UserID' => $loans_applylist['UserID']))->find();//银行卡认证信息
        $mem_info = M('mem_info')->where(array('ID' => $loans_applylist['UserID']))->find();//会员信息
        $this->assign(array(
            "loans_applylist" => $loans_applylist,
            "renzen_bank" => $renzen_bank,
            "mem_info" => $mem_info,
        ));
//			p($loans_applylist);die;
        $this->display();
    }

    //确认放款信息提交处理
    public function aduitsave()
    {
        $ID = I('post.ID', '');
        $id = I('post.ID', '');
        $TradeNum = I('post.TradeNum', '');//交易号 暂时为订单号
        $ReplaymentType = I('post.ReplaymentType', '');//支付方式 1支付宝 2微信 3银联 4富有
        $TrueName = I('post.TrueName', '');//姓名
        $RepaymentAccount = I('post.RepaymentAccount', '');//打款账号
        $UserAccount = I('post.UserAccount', '');//收款账号
        $editdays = I('post.editdays', '');//修改的时间字段
        //审核校验
        $applyinfos = M(self::T_TABLE)->where(array("ID" => $ID))->find();
        if (!$applyinfos) {
            $this->ajaxReturn(0, '很抱歉，无此申请记录！');
        }
//		判断打款条件  如果 等于1 是等待放款  7是银行卡失败 执行手动放款
        if ($applyinfos['LoanStatus'] != '1') {
            if ($applyinfos['LoanStatus'] != '7') {
                $this->ajaxReturn(0, '很抱歉，不能重复放款！');
            }
        }
        if (!$TradeNum) {
            $this->ajaxReturn(0, '交易号不能为空!');
        }
        if ($ReplaymentType == 1) {
            if (!$RepaymentAccount) {
                $this->ajaxReturn(0, '打款s账号不能为空!');
            }
        }
        if ($ReplaymentType == 2) {
            if (!$RepaymentAccount) {
                $this->ajaxReturn(0, '打款s账号不能为空!');
            }
        }
//      if($editdays){
//          if(!is_numeric($editdays)){
//              $this->ajaxReturn(0,'修改时间必须为数字!');
//          }
//          if($editdays<=0){
//              $this->ajaxReturn(0,'修改时间必须大于0!');
//          }
//      }
        $loans_applylist = M('loans_applylist')->where(array('ID' => $id))->find();//订单信息
        $renzen_bank = M('renzen_bank')->where(array('UserID' => $loans_applylist['UserID']))->find();//银行卡认证信息
        $mem_info = M('mem_info')->where(array('ID' => $loans_applylist['UserID']))->find();//会员信息
//		处理银联打款
        if ($ReplaymentType == 3) {
            //		数组组合
//            $data['accntno'] = $renzen_bank['BankNo'];//用户账号
//            $data['accntnm'] = $mem_info['TrueName'];//账户名称
//            $data['branchnm'] = $renzen_bank['OpenBankName'];//支行名称
//            $data['branchnm'] = $renzen_bank['YMobile'];//手机号
//            $data['amt'] = explode(".", $loans_applylist['OpenM'])['0'];//金额
//            $data['amt'] = $data['amt'] * 100;
//            $data['orderno'] = $loans_applylist['OrderSn'];//借款订单号 用于回调识别
//            $data['memberCode'] = M('sys_inteparameter')->where(['ParaName' => 'kq_memberCode'])->getField('ParaValue');//商户秘钥
//
//
//            $data['amount'] = $amount;//金额
//            $data['orderId'] = $order_no;//订单号
//            $data['cardHolderName'] = $mem_info['TrueName'];//持卡人姓名
//            $data['BankNo'] = $renzen_bank['BankNo'];//银行卡号
//            $data['BankName'] = $renzen_bank['BankName'];//银行名称
//            $data['OpenBankName'] = $renzen_bank['OpenBankName'];//开户支行名称
//            $data['Mobile'] = $renzen_bank['YMobile'];//手机号
//            $data['memberCode'] = $memberCode;
//
//            /*
//             * 富友支付
//             * $Fuyou=new \Fuyou\Fuiou;
//            $result=$Fuyou->parfuyou($data);*/
//            $Kuaiqian = new \Kuaiqian\Kuaiqian;
//            $result = $Kuaiqian->parkuaiqian($data);
            $this->ajaxReturn(0, '请选择协议付款');
//            if ($result['status'] == 1) {
//                $re = M('loans_applylist')->where(array("ID" => $ID))->save(['LoanStatus' => '6']);
//                if ($re) {
//                    $this->ajaxReturn(1, '恭喜您，放款订单提交成功 请等待银行打款！');
//                }
//            } else {
//                $this->ajaxReturn(0, $result['msg']);
//            }
        } else {//微信支付宝打款
            $sdata = array();//修改的数据
            if ($editdays) {
                //修改放款时间，用于测试
                $sdata['ApplyTime'] = date("Y-m-d H:i:s", strtotime("-" . $editdays . " day"));
                $sdata['LoanStatus'] = '2';
                $sdata['ShTime'] = date("Y-m-d H:i:s", strtotime("-" . $editdays . " day"));
                $sdata['FkServiceID'] = $_SESSION['AdminInfo']['AdminID'];
                $sdata['OpenTime'] = date("Y-m-d H:i:s", strtotime("-" . $editdays . " day"));
                $fktimes = date("Y-m-d H:i:s", strtotime("-" . $editdays . " day"));
                //$YyFkTime=strtotime($fktimes)+$applyinfos['ApplyDay']*86400;
                $YyFkTime = strtotime($fktimes) + ($applyinfos['ApplyDay'] - 1) * 86400;
                $sdata['YyFkTime'] = date("Y-m-d H:i:s", $YyFkTime);
                $sdata['ReplaymentType'] = $ReplaymentType;
                $sdata['RepaymentAccount'] = $RepaymentAccount;
                $sdata['TradeNum'] = $TradeNum;
                if ($UserAccount) {
                    $sdata['UserAccount'] = $UserAccount;
                }
                $sdata['OperatorID'] = $_SESSION['AdminInfo']['AdminID'];
                $sdata['UpdateTime'] = date("Y-m-d H:i:s", strtotime("-" . $editdays . " day"));
            } else {
                //正常放款
                $sdata['LoanStatus'] = '2';//订单状态
                $sdata['FkServiceID'] = $_SESSION['AdminInfo']['AdminID'];//操作者id
                $sdata['OpenTime'] = date('Y-m-d H:i:s');//放款时间
                //$sdata['YyFkTime']=date("Y-m-d H:i:s",strtotime("+".$applyinfos['ApplyDay']." day"));
                $realdays = $applyinfos['ApplyDay'] - 1;
                $sdata['YyFkTime'] = date("Y-m-d H:i:s", strtotime("+" . $realdays . " day"));//预约还款时间
                $sdata['ReplaymentType'] = $ReplaymentType;//打款方式
                $sdata['RepaymentAccount'] = $RepaymentAccount;//打款账号
                $sdata['TradeNum'] = $TradeNum;//交易号-付款生存的单号，手动填写
                if ($UserAccount) {
                    $sdata['UserAccount'] = $UserAccount;//会员账号
                }
                $sdata['OperatorID'] = $_SESSION['AdminInfo']['AdminID'];//操作者id
                $sdata['UpdateTime'] = date('Y-m-d H:i:s');
            }
            $model = M();
            $model->startTrans();
            $result = $model->table('xb_loans_applylist')->where(array("ID" => $ID))->save($sdata);
            if ($result) {
                //发送消息通知信息
                $msgcont = '尊敬的会员，您提交的订单：' . $applyinfos['LoanNo'] . '，打款成功!金额为：' . $applyinfos['OpenM'] . '元。';
                $mobile = M('mem_info')->where(array('ID' => $applyinfos['UserID']))->getField('Mobile');
                send_message($mobile, $msgcont);//发送短信消息
                send_mem_notics($applyinfos['UserID'], $msgcont);//发送站内通知消息
                self_sendjuan($applyinfos['UserID'], '5');//邀请的好友申请专卖成功立送
                $model->commit();
                $this->ajaxReturn(1, '恭喜您，放款操作成功！');
            } else {
                $model->rollback();
                $this->ajaxReturn(0, '很抱歉，放款操作失败！');
            }
        }
    }

    public function detail()
    {
        $ID = I('request.ID');
        $infos = M(self::T_TABLE)->alias('a')
            ->field('a.*,b.Mobile,b.TrueName')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.ID' => $ID))->find();
        if ($infos['FkServiceID']) {
            $infos['FkServiceID'] = M(self::T_ADMIN)->where(array('ID' => $infos['FkServiceID']))->getField('TrueName');
        }
        $LoanStatusArr = $this->LoanStatus;
        $StatusArr = $this->Status;
        $LoanTypeArr = $this->LoanType;
        $infos['LoanStatus'] = $LoanStatusArr[$infos['LoanStatus']];
        $infos['Status'] = $StatusArr[$infos['Status']];
        $infos['LoanType'] = $LoanTypeArr[$infos['LoanType']];
        //身份证认证
        $cardinfos = M('renzen_cards')->alias('a')
            ->field('a.ID,a.Yddatas,a.Status,a.RenzTime,a.CardFace,a.CardSide,a.Cardschi,b.Mobile,b.TrueName,b.IDCard')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID' => $infos['UserID']))->find();
        if ($cardinfos['Yddatas']) {
            $cardinfos['Yddatas'] = unserialize($cardinfos['Yddatas']);
        }
        $cardimgArr = array();
        $cardimgArr[] = $cardinfos['CardFace'];
        $cardimgArr[] = $cardinfos['CardSide'];
        $cardimgArr[] = $cardinfos['Cardschi'];
        //手机认证
        $mobileinfos = M('renzen_mobile')->alias('a')
            ->field('a.ZUserName,a.OpenDate,a.AccountBalance,a.Status,a.RenzTime,b.Mobile,b.TrueName')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID' => $infos['UserID']))->find();
        //支付宝认证
        $alipayinfos = M('renzen_alipay')->alias('a')
            ->field('a.TaobaoName,a.Balance,a.HuabeiBalance,a.HuabeiLimit,a.HuabeiRet,a.ZFBMobile,a.Email,a.RenzTime,a.Status,b.Mobile,b.TrueName')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID' => $infos['UserID']))->find();
        //淘宝认证
        $taobaoinfos = M('renzen_taobao')->alias('a')
            ->field('a.BDMobile,a.Levels,a.Balance,a.JBalance,a.UserName,a.XFQuote,a.XYQuote,a.ZmScore,a.JieBei,a.YZStatus,a.RenzTime,a.Status,b.Mobile,b.TrueName')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID' => $infos['UserID']))->find();
        //基本信息认证
        $jibeninfos = M('renzen_memberinfo')->alias('a')
            ->field('a.*,b.Mobile,b.TrueName,b.NickName,b.Sex')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID' => $infos['UserID']))->find();
        //社交认证
        $socialinfos = M('renzen_social')->field('ID,QQ,WeChat,Contents,Status,RenzTime')->where(array('UserID' => $infos['UserID'], 'IsDel' => '0'))->find();
        if ($socialinfos['Contents']) {
            $socialinfos['Contents'] = unserialize($socialinfos['Contents']);
        }
        //银行卡认证
        $bankinfos = M('renzen_bank')->alias('a')
            ->field('a.BankName,a.OpenBankName,a.BankNo,a.Address,a.YMobile,a.RenzTime,a.Status,b.TrueName,b.IDCard')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID' => $infos['UserID']))->find();
        $this->assign(array(
            'infos' => $infos,
            'cardinfos' => $cardinfos,
            'cardimgArr' => $cardimgArr,
            'mobileinfos' => $mobileinfos,
            'alipayinfos' => $alipayinfos,
            'taobaoinfos' => $taobaoinfos,
            'jibeninfos' => $jibeninfos,
            'socialinfos' => $socialinfos,
            'bankinfos' => $bankinfos,
        ));
        $this->display();
    }

    //转单页面
    public function zorder()
    {
        $id = I('get.ID', 0, 'intval');
        $res = M(self::T_TABLE)->field('ID,FKadminID')->where(array("ID" => $id))->find();
        $kefuArr = M(self::T_ADMIN)->field('ID,TrueName')->where(array('RoleID' => '8', 'Status' => '1', 'IsDel' => '0'))->select();
        $this->assign(array(
            'res' => $res,
            'kefuArr' => $kefuArr,
        ));
        $this->display();
    }

    //转单保存
    public function zordersave()
    {
        $ID = I('post.ID', '');
        $FKadminID = I('post.FKadminID', '0');
        if (!$FKadminID) {
            $this->ajaxReturn(0, '很抱歉，请选择放款专员！');
        }
        $result = M(self::T_TABLE)->where(array('ID' => $ID))->save(array('FKadminID' => $FKadminID));
        if ($result) {
            $this->ajaxReturn(1, '恭喜您，转单成功成功！');
        } else {
            $this->ajaxReturn(0, '很抱歉，转单失败！');
        }
    }

    //取消放款页面
    public function cancelloan()
    {
        $id = I('get.ID', 0, 'intval');
        $res = M(self::T_TABLE)->field('ID')->where(array("ID" => $id))->find();
        $this->assign(array(
            'res' => $res,
        ));
        $this->display();
    }

    //取消放款保存
    public function cancelsave()
    {
        $ID = I('post.ID', '');
        $Remark = I('post.Remark', '');
        //审核校验
        $applyinfos = M(self::T_TABLE)->field('ID,UserID,LoanNo,LoanStatus')->where(array("ID" => $ID))->find();
        if (!$applyinfos) {
            $this->ajaxReturn(0, '很抱歉，无此申请记录！');
        }
        if ($applyinfos['LoanStatus'] != '1') {
            $this->ajaxReturn(0, '很抱歉，只能取消未放款的申请！');
        }
        if (!$Remark) {
            $this->ajaxReturn(0, '很抱歉，请写明取消原因！');
        }
        //$result=M(self::T_TABLE)->where(array('ID'=>$ID))->save(array('FKadminID'=>$Remark));
        $sdata = array();//修改的数据
        $sdata['LoanStatus'] = '5';
        $sdata['ServiceID'] = $_SESSION['AdminInfo']['AdminID'];
        $sdata['ShTime'] = date('Y-m-d H:i:s');
        $sdata['Status'] = '2';
        $sdata['Remark'] = $Remark;
        $sdata['OperatorID'] = $_SESSION['AdminInfo']['AdminID'];
        $sdata['UpdateTime'] = date('Y-m-d H:i:s');

        $model = M();
        $model->startTrans();
        $result = $model->table('xb_loans_applylist')->where(array("ID" => $ID))->save($sdata);
        if ($result) {
            //发送消息通知信息
            $msgcont = '尊敬的会员，您提交的订单：' . $applyinfos['LoanNo'] . '，审核失败!失败原因：' . $Remark;
            send_mem_notics($applyinfos['UserID'], $msgcont);//发送站内通知消息

            $model->commit();
            $this->ajaxReturn(1, '恭喜您，取消操作成功！');
        } else {
            $model->rollback();
            $this->ajaxReturn(0, '很抱歉，取消操作失败！');
        }
    }

    //导出功能
    public function exportexcel()
    {
        $sort = I('post.sort');
        $order = I('post.order');
        if ($sort && $order) {
            $sort = $sort . ' ' . $order;
        } else {
            $sort = 'ID desc';
        }

        //搜索条件
        $TrueName = I('post.TrueName', '');
        if ($TrueName) {
            $memidArr = M(self::T_MEMINFO)->field('ID')->where(array('TrueName' => array('like', '%' . $TrueName . '%')))->select();
            if ($memidArr) {
                $memids = array();
                foreach ($memidArr as $k => $v) {
                    $memids[] = $v['ID'];
                }
                //$memids=array_column($memidArr, 'ID');
                $where['UserID'] = array('in', $memids);
            } else {
                $where['UserID'] = array('eq', '0');
            }
        }
        $Mobile = I('post.Mobile', '');
        if ($Mobile) {
            $memidArr = '';
            $memidArr = M(self::T_MEMINFO)->field('ID')->where(array('Mobile' => array('eq', $Mobile)))->select();
            if ($memidArr) {
                $memids = array();
                foreach ($memidArr as $k => $v) {
                    $memids[] = $v['ID'];
                }
                $where['UserID'] = array('in', $memids);
            } else {
                $where['UserID'] = array('eq', '0');
            }
        }
        $LoanStatus = I('post.LoanStatus', -5, 'int');
        if ($LoanStatus != -5) {
            $where['LoanStatus'] = $LoanStatus;
        } else {
            $where['LoanStatus'] = array('in', array('1', '2', '3'));
        }
        $LoanNo = I('post.LoanNo', '');
        if ($LoanNo) {
            $where['LoanNo'] = $LoanNo;
        }
        $OrderSn = I('post.OrderSn', '');
        if ($OrderSn) {
            $where['OrderSn'] = $OrderSn;
        }
        $ReplaymentType = I('post.ReplaymentType', -5, 'int');
        if ($ReplaymentType != -5) {
            $where['ReplaymentType'] = $ReplaymentType;
        }
        //放款时间
        $StartTime = I('post.StartTime');  //按时间查询
        $EndTime = I('post.EndTime');
        $ToStartTime = $StartTime;
        $ToEndTime = date('Y-m-d', strtotime($EndTime . "+1 day"));
        if ($StartTime != null) {
            if ($EndTime != null) {
                //有开始时间和结束时间
                $where['OpenTime'] = array('between', $ToStartTime . ',' . $ToEndTime);
            } else {
                //只有开始时间
                $where['OpenTime'] = array('egt', $ToStartTime);
            }
        } else {
            //只有结束时间
            if ($EndTime != null) {
                $where['OpenTime'] = array('elt', $ToEndTime);
            }
        }

        $where['IsDel'] = 0;
        //查询的数据表字段名
        $col = 'ID,UserID,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney,ApplyDay,ApplyTime,OpenM,LoanStatus,FkServiceID,OpenTime,ReplaymentType,RepaymentAccount,TradeNum,UserAccount,OrderSn,LoanNo';//默认全字段查询

        //获取主表的数据
        $query = new XBCommon\XBQuery;
        $array['rows'] = M(self::T_TABLE)->where($where)->order($sort)->select();

        $LoanStatusArr = $this->LoanStatus;
        $StatusArr = $this->Status;
        $LoanTypeArr = $this->LoanType;
        //重组数据返还给前段
        $result = array();
        if ($array['rows']) {
            foreach ($array['rows'] as $val) {
                $meminfo = M(self::T_MEMINFO)->field('TrueName,Mobile')->where(array('ID' => $val['UserID']))->find();
                $val['TrueName'] = $meminfo['TrueName'];
                $val['Mobile'] = $meminfo['Mobile'];
                $val['FkServiceID'] = $query->GetValue(self::T_ADMIN, array('ID' => (int)$val['FkServiceID']), 'TrueName');
                $val['LoanStatus'] = $LoanStatusArr[$val['LoanStatus']];
                $val['Status'] = $StatusArr[$val['Status']];
                $val['LoanType'] = $LoanTypeArr[$val['LoanType']];
                if ($val['ReplaymentType'] == '0') {
                    $val['ReplaymentType'] = '未打款';
                } elseif ($val['ReplaymentType'] == '1') {
                    $val['ReplaymentType'] = '支付宝';
                } elseif ($val['ReplaymentType'] == '2') {
                    $val['ReplaymentType'] = '微信';
                } elseif ($val['ReplaymentType'] == '3') {
                    $val['ReplaymentType'] = '银联';
                } elseif ($val['ReplaymentType'] == '4') {
                    $val['ReplaymentType'] = '代付';
                }
                $result['rows'][] = $val;
            }
        }

        //导出拼装
        $html = '<table cellpadding="1" cellspacing="1" border="1" width="100%" bgcolor="#000000;">
            <tr bgcolor="#FFFFFF">
                <td bgcolor="#FFFFFF" align="center" _REQUEST>序号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>真实姓名</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>手机号码</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请金额</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>快速申请费</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>用户管理费</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>息费</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>优惠劵金额</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请天数</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请时间</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>放款金额</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>放款状态</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>放贷人员</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>审核时间</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>打款方式</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>账号/卡号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>交易号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>会员账号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>订单号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请号</td>
            </tr>';

        foreach ($result['rows'] as $key => $row) {
            $html .= '<tr bgcolor="#FFFFFF">
                <td bgcolor="#FFFFFF" align="center" >' . intval($key + 1) . '</td>
                <td bgcolor="#FFFFFF" align="center">' . $row['TrueName'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['Mobile'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['ApplyMoney'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['AdoptMoney'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['FJMoney'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['Interest'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['CoMoney'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['ApplyDay'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['ApplyTime'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['OpenM'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['LoanStatus'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['FkServiceID'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['OpenTime'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['ReplaymentType'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['RepaymentAccount'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['TradeNum'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['UserAccount'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['OrderSn'] . '</td>
                <td bgcolor="#FFFFFF" align="center" >' . $row['LoanNo'] . '</td>
            </tr>';
        }

        $html .= '</table>';
        $str_filename = date('Y-m-d', time()) . '放款记录列表';
        //$str_filename = iconv('UTF-8', 'GB2312//IGNORE',$str_filename);
        $html = iconv('UTF-8', 'GB2312//IGNORE', $html);
        ob_end_clean();//清除缓存区的内容
        header("Content-type: application/vnd.ms-excel; charset=GBK");
        //header('Content-Type:text/html;charset=utf-8');
        header("Content-Disposition: attachment; filename=$str_filename.xls");
        echo $html;
        exit;
    }

    /**
     * @功能说明：获取账号 ycp
     */
    public function getaccuonts()
    {
        $types = I('post.types', '0');
        $id = I('post.id', '0');
        $list = M(self::T_ACCOUNTS)->where(array('Types' => $types, 'IsDel' => '0'))->select();
        if ($id) {
            $gdinfos = M(self::T_TABLE)->field('RepaymentAccount')->find($id);
        }
        $htmls = '';
        if ($list) {
            if ($gdinfos) {
                foreach ($list as $k => $v) {
                    if ($gdinfos['RepaymentAccount'] == $v['Name']) {
                        $htmls .= "<option value='" . $v['Name'] . "' selected>" . $v['Name'] . "</option>";
                    } else {
                        $htmls .= "<option value='" . $v['Name'] . "'>" . $v['Name'] . "</option>";
                    }
                }
            } else {
                foreach ($list as $k => $v) {
                    $htmls .= "<option value='" . $v['Name'] . "'>" . $v['Name'] . "</option>";
                }
            }
        }
        echo $htmls;
        return false;
    }

}
