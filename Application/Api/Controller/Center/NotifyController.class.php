<?php
namespace Api\Controller\Center;
use Api\Controller\Core\BaseController;
use XBCommon\XBCache;
/**
 * 回调通知类
 */
class NotifyController {

// 魔蝎运营商认证 任务创建通知URL
	public function notify_start(){
        $requestBody = @file_get_contents("php://input");
        $mydata=json_decode($requestBody,1);
		$task_id=$mydata['task_id'];
		$name=$mydata['name'];
        $UserID = $mydata['user_id'];
		$sdata=array(
            'UserID'=>$UserID,
            'Status'=>'0',
            'RenzTime'=>date('Y-m-d H:i:s'),
			'TaskID'=>$task_id,
			'ZUserName'=>$name,
            );
		$checkrest=M('renzen_mobile')->field('ID')->where(array('UserID'=>$UserID,'IsDel'=>'0'))->find();
		if($checkrest){					
            $result=M('renzen_mobile')->where(array('ID'=>$checkrest['ID']))->save($sdata);
        }else{
            $result=M('renzen_mobile')->add($sdata);
        }
        header("HTTP/1.1 201 Created");
        $myfile = fopen("chaungjianshouji.txt", "w") or die("Unable to open file!");
        fwrite($myfile,date('Y-m-d h:i:s',time()));
        fwrite($myfile,$requestBody);
        fclose($myfile);
	}

//魔蝎手机认证回调  获取报告数据 和加密串
    public function notify_moximobile(){
        $requestBody = @file_get_contents("php://input");
        $mydata=json_decode($requestBody,1);
        $token=M('sys_inteparameter')->where(array('ParaName'=>'tokenmoxie'))->getField('ParaValue');//获取token
        $meminfos=M('mem_info')->field('TrueName,IDCard,Mobile,ID')->where(array('ID'=>$mydata['user_id']))->find();//获取手机号
        //		查看报告数据
        $urbapgao='https://api.51datakey.com/carrier/v3/mobiles/'.$meminfos['Mobile'].'/mxreport?name='.$meminfos['TrueName'].'&idcard='.$meminfos['IDCard'].'&task_id='.$mydata['task_id'].'&contact=';
        $urbapgaodate=mobile_renzheng($urbapgao,$token);
        $data['mistr']=$mydata['message'];
        $data['baogao']=$urbapgaodate;
        $re=M('renzen_mobile')->where(array('UserID'=>$mydata['user_id']))->save($data);
        header("HTTP/1.1 201 Created");
        $myfile = fopen("shouji.txt", "w") or die("Unable to open file!");
        fwrite($myfile,date('Y-m-d h:i:s',time()));
        fwrite($myfile,$requestBody);
        fwrite($myfile,$urbapgaodate);//报告数据
        fclose($myfile);
    }

    //手机认证账单通知回调  获去原始数据
    public function notify_zhangdan_shouji(){
        $requestBody = @file_get_contents("php://input");
        $mydata=json_decode($requestBody,1);
        $token=M('sys_inteparameter')->where(array('ParaName'=>'tokenmoxie'))->getField('ParaValue');//获取token
        $urlmoxie=M('sys_inteparameter')->where(array('ParaName'=>'urlmoxie'))->getField('ParaValue');//获取请求地址
        $meminfos=M('mem_info')->field('TrueName,IDCard,Mobile,ID')->where(array('ID'=>$mydata['user_id']))->find();//获取手机号
        $url=$urlmoxie.'/'.$meminfos['Mobile'].'/mxdata-ex?task_id='.$mydata['task_id'];
        $res=mobile_renzheng($url,$token);	//获取运营商认证数据
        $sdata['CallBill']=$res;
        $sdata['Status']='1';
        $re=M('renzen_mobile')->where(array('UserID'=>$mydata['user_id']))->save($sdata);
        header("HTTP/1.1 201 Created");
        $myfile = fopen("shoujizhangdan.txt", "w") or die("Unable to open file!");
        fwrite($myfile,date('Y-m-d h:i:s',time()));
        fwrite($myfile,$requestBody);//返回数据
        fwrite($myfile,$res);//原始数据
        fclose($myfile);
    }


    // 魔蝎淘宝认证 任务创建通知URL
    public function notify_taobaostart(){
        $requestBody = @file_get_contents("php://input");
        $mydata=json_decode($requestBody,1);
        $task_id=$mydata['task_id'];
        $UserID = $mydata['user_id'];
        $sdata=array(
            'UserID'=>$UserID,
            'Status'=>'0',
            'RenzTime'=>date('Y-m-d H:i:s'),
            'TaskID'=>$task_id,
        );
        $checkrest=M('renzen_taobao')->field('ID')->where(array('UserID'=>$UserID,'IsDel'=>'0'))->find();
        if($checkrest){
            $result=M('renzen_taobao')->where(array('ID'=>$checkrest['ID']))->save($sdata);
        }else{
            $result=M('renzen_taobao')->add($sdata);
        }
        header("HTTP/1.1 201 Created");
        $myfile = fopen("taobaostart.txt", "w") or die("Unable to open file!");
        fwrite($myfile,date('Y-m-d h:i:s',time()));
        fwrite($myfile,$requestBody);
        fclose($myfile);
    }

//魔蝎淘宝认证回调
 public function notify_moxiebaogao(){
		$requestBody = @file_get_contents("php://input");
	    $mydata=json_decode($requestBody,1);
		$mistr=$mydata['message'];
	    $re=M('renzen_taobao')->where(array('UserID'=>$mydata['user_id']))->save(array('mistr'=>$mistr));
		header("HTTP/1.1 201 Created");
		$myfile = fopen("taobao.txt", "w") or die("Unable to open file!");
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$requestBody);
		fclose($myfile);
    }
   //淘宝认证账单通知uri
   public function notify_zhangdan(){
		$requestBody = @file_get_contents("php://input");
	    $mydata=json_decode($requestBody,1);
		$token=M('sys_inteparameter')->where(array('ParaName'=>'tokenmoxie'))->getField('ParaValue');
		$res=taobao_renzhen($mydata['task_id'],$token);	//获取淘宝认证数据
		$reszhima=taobao_renzhen_zhima($mydata['task_id'],$token);	//芝麻分获取
		$data['Receivers']=$res;
		$data['zhimafen']=json_decode($reszhima,1)['zm_score'];
//      $data['zhimafen']=$reszhima;
	    $re=M('renzen_taobao')->where(array('UserID'=>$mydata['user_id']))->save($data);	
		if($re){
			 $status['Status']=1;
            $result=M('renzen_taobao')->where(array('UserID'=>$mydata['user_id']))->save($status);
		}else{
			$status['Status']=2;
			 $result=M('renzen_taobao')->where(array('UserID'=>$mydata['user_id']))->save($status);
		}
		header("HTTP/1.1 201 Created");
		$myfile = fopen("taobaozhangdan.txt", "w") or die("Unable to open file!");
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$requestBody);
		fwrite($myfile,$reszhima);
		fclose($myfile);
	
    }


   
   //修改订单状态延时操作
		public function LoanStatus(){
	    $data=json_encode($_POST);
		sleep(30);
		$myfile = fopen("zzzzzz.txt", "w") or die("Unable to open file!");
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$data);
		fclose($myfile);
		M('loans_applylist')->where(array('ID'=>$_POST['ID']))->save(array('LoanStatus'=>'5'));
				
		}

//有凭证回调地址
public function youpingzheng(){
    	$requestBody = @file_get_contents("php://input");
		$data=json_decode($requestBody,1);
		$myfile = fopen("YYYYYYYYYYYYYYYYYYYYYYYYYYYYY.txt", "w") or die("Unable to open file!");
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$requestBody);
		fclose($myfile);
		$ur2='http://credit.beikeyuntiao.com/api/ypz/get-report?phone='.$data['phone'];
		$resp=httpGet($ur2);
		$sdatall=array(
            'UserID'=>$UserID,
            'TaskID'=>$para['taskid'],
            'Status'=>'1',
            );
		$RE=M('renzen_alipay')->add($sdatall);
//		M('xb_renzen_alipay')->where(['ID'=>$_POST['ID']])->save(['LoanStatus'=>'5']);		
		}
//2018-11-09 11:30:20
//amt=800&
//result=%E6%B8%A0%E9%81%93%E8%B5%84%E9%87%91%E5%88%B0%E8%B4%A6%E5%B7%B2%E5%A4%8D%E6%A0%B8%2C%E4%BA%A4%E6%98%93%E5%B7%B2%E5%8F%91%E9%80%81&
//bankno=0308&
//reason=%E6%88%90%E5%8A%9F&
//merdt=20181109&
//accntno=6214835897170831
//&state=1&
//orderno=1811092232126158&
//accntnm=%E5%AE%8B%E6%9E%97%E5%8D%9A&
//mac=ec25ec8847c234bbb5d42db65b3a51e8&
//fuorderno=492321694414180062148358971708311811092232126158
//	富有打款成功回调通知
	public function fuyou_notif_daozhang(){
		$requestBody = @file_get_contents("php://input");
		$state=$_POST['state'];//z状态
		$amte=$_POST['amt'];//金额
	    $accntno=$_POST['accntno'];//卡号
	    $orderno=$_POST['orderno'];//借款订单号  用于做唯一识别
		$myfile = fopen("yyyyyyyyyyyyyyyyyyyyyy.txt", "w") or die("Unable to open file!");
		fwrite($myfile,$requestBody);
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$state);
		fwrite($myfile,$amte);
		fwrite($myfile,$accntno);
		fwrite($myfile,$orderno);
		fclose($myfile);
		if($state=='1'){//支付成功	
//		       修改订单状态   先查询订单信息
//	               根据银行卡号去获取用户id
                    $applyinfos=M('loans_applylist')->where(array('OrderSn'=>$orderno))->find();//查找当前订单ID
					$sdata=array();//修改的数据      
		            //正常放款
		            $sdata['LoanStatus']='2';//订单状态
		            $sdata['FkServiceID']=$_SESSION['AdminInfo']['AdminID'];//操作者id
		            $sdata['OpenTime']=date('Y-m-d H:i:s');//放款时间
		            //$sdata['YyFkTime']=date("Y-m-d H:i:s",strtotime("+".$applyinfos['ApplyDay']." day"));
		            $realdays=$applyinfos['ApplyDay']-1;
		            $sdata['YyFkTime']=date("Y-m-d H:i:s",strtotime("+".$realdays." day"));//预约还款时间
		            $sdata['ReplaymentType']='3';//打款方式
		            $sdata['OperatorID']=$_SESSION['AdminInfo']['AdminID'];//操作者id
		            $sdata['UpdateTime']=date('Y-m-d H:i:s');    
			        $model=M();
			        $model->startTrans();
			        $result=$model->table('xb_loans_applylist')->where(array("ID"=>$applyinfos['ID']))->save($sdata);
		        if($result){
		            //发送消息通知信息
		            $msgcont='尊敬的会员，您提交的订单：'.$applyinfos['LoanNo'].'，打款成功!金额为：'.$applyinfos['OpenM'].'元。';
		            $mobile=M('mem_info')->where(array('ID'=>$applyinfos['UserID']))->getField('Mobile');
		            send_message($mobile,$msgcont);//发送短信消息
		            send_mem_notics($applyinfos['UserID'],$msgcont);//发送站内通知消息
		            self_sendjuan($applyinfos['UserID'],'5');//邀请的好友申请专卖成功立送
		            $model->commit();
		            $this->ajaxReturn(1,'恭喜您，放款操作成功！');
		        }else{
		            $model->rollback();    
		        }
		}
       
	}
	//退票通知地址： 
	public function fuyou_notify_tuipiao(){
		$requestBody = @file_get_contents("php://input");
		$state=$_POST['state'];//z状态
		$amte=$_POST['amt'];//金额
	    $accntno=$_POST['accntno'];//卡号
	    $orderno=$_POST['orderno'];//借款订单号  用于做唯一识别
		$myfile = fopen("xxxxxxxxxxxxxxxx.txt", "w") or die("Unable to open file!");
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$requestBody);
		fwrite($myfile,$state);
		fwrite($myfile,$amte);
		fwrite($myfile,$accntno);
		fwrite($myfile,$orderno);
		fclose($myfile);
		if($state=='1'){//支付成功	
//		       修改订单状态   先查询订单信息
//	               根据银行卡号去获取用户id
                    $applyinfos=M('loans_applylist')->where(array('OrderSn'=>$orderno))->find();//查找当前订单ID
					$sdata=array();//修改的数据      
		            //正常放款
		            $sdata['LoanStatus']='7';//订单状态
		            $sdata['FkServiceID']=$_SESSION['AdminInfo']['AdminID'];//操作者id
		            $sdata['ReplaymentType']='3';//打款方式
		            $sdata['OperatorID']=$_SESSION['AdminInfo']['AdminID'];//操作者id
		            $sdata['UpdateTime']=date('Y-m-d H:i:s');    
			        $model=M();
			        $model->startTrans();
			        $result=$model->table('xb_loans_applylist')->where(array("ID"=>$applyinfos['ID']))->save($sdata);
		        if($result){
		            //发送消息通知信息
		            $msgcont='尊敬的会员，您提交的订单：'.$applyinfos['LoanNo'].'，打款失败!金额为：'.$applyinfos['OpenM'].'元。请联系客服及时处理';
		            $mobile=M('mem_info')->where(array('ID'=>$applyinfos['UserID']))->getField('Mobile');
		            send_message($mobile,$msgcont);//发送短信消息
		            send_mem_notics($applyinfos['UserID'],$msgcont);//发送站内通知消息
		            self_sendjuan($applyinfos['UserID'],'5');//邀请的好友申请专卖成功立送
		            $model->commit();
//		            $this->ajaxReturn(1,'恭喜您，放款操作成功！');
		        }else{
		            $model->rollback();
		        }
		}
       
	}
	//签约通知地址： 
	public function fuyou_notify_qianyue(){
		$requestBody = @file_get_contents("php://input");
		$myfile = fopen("zzzzzzzzzzzzzzzzzz.txt", "w") or die("Unable to open file!");
		fwrite($myfile,date('Y-m-d h:i:s',time()));
		fwrite($myfile,$requestBody);
		fclose($myfile);
	}
	
//	ios获取版本号
	 public function version(){
        $para = get_json_data();

        $find = M('version')->field('ID,Ver,isForced,Url,Updates')->where(array("Client"=>$para['client'],"IsDefault"=>1))->find();

        if($find){
            $find['Updates'] = htmlspecialchars_decode($find['Updates']);
            AjaxJson(0,1,'success',$find);
        }else{
            $find = M('version')->field('ID,Ver,isForced,Url,Updates')->where(array("Client"=>$para['client'],"Status"=>'1','Ver'=>$para['version']))->find();
            AjaxJson(0,1,'success',$find);
        }
    }
}