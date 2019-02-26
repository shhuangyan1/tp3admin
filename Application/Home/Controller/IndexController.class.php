<?php
/**
 * 功能说明: 首页部分
 */
namespace Home\Controller;
use XBCommon\XBCache;
class IndexController extends HomeController{
 const T_MOBILE='renzen_mobile';//手机认证表
    //口子首页
    public function kouzi(){
    	//查找最新4条记录
    	$itemlist=M('tg_items')->field('ID,Name,Intro,Logurl,Url')->where(array('IsTui'=>'1','Status'=>'1','IsDel'=>'0'))->select();
    	$this->assign(array(
    		'itemlist'=>$itemlist,
    		));
    	$this->display();
    }
	  public function baogao(){
	  	 $id=I('get.id',0,'intval');
	     $mobileinfos=M('renzen_cards')->where(array('ID'=>$id,'IsDel'=>'0'))->getField('Yddatas');
	     $youdun=unserialize($mobileinfos);
	  	 $this->assign('data',$youdun);
         $this->display();
    }
    public function mozhang(){
        $id=I('get.id',0,'intval');
        $bgdata=M('moxie_mozhang')->where(array('ID'=>$id))->getField('BgData');
//        $mozhang=json_decode($bgdata);
        $mozhang=json_decode($bgdata,true);
//        $mozhang =['msg'=>'ceshishishi'];
        $this->assign('data',$mozhang);
        $this->display();
    }
	   public function heimingdanyemian(){               
	  	 $id=I('get.id',0,'intval'); 
	     $memberdata=M('mem_info')->field('TrueName,IDCard,Mobile')->where(array('ID'=>$id))->find();
		 $url='http://credit.beikeyuntiao.com/api/black-jdb/get-report';
         $token = "drfa1cyker0neuq53bdpev753qw43n31";
	     $postDate = [
	     "phone"  => $memberdata['Mobile'],
	     "name"   => $memberdata['TrueName'],
	     "idcard" => $memberdata['IDCard']
		 ];
		$header = [
		    "X-Mall-Token: " . $token,
		    'Content-Type: text/html; charset=utf-8',
		];
		$postDate['time']=date('Y-m-d h:i:s',time());
        $response = doGet($url,$postDate,$header);
//		p($response);
		$this->assign('postDate',$postDate);
//		p($postDate);
	  	$this->assign('data',$response);
        $this->display();
    }

//收集数据
//手机号 真是姓名 身份证号码  会员ID
    public function get_date(){
    $rqend = date('Y-m-d');//截止时间
	$rqstart=date("Y-m-d",strtotime("-1 day"));//开始时间
    $map['RegTime']  = array('between',array($rqstart,$rqend));
	$data=M('mem_info')->where($map)->field('ID,Mobile,TrueName,IDcard,RegTime')->select();  
//	P($data);
	foreach ($data as $k => $v) {
//		P($v);DIE;
			$LoanStatus=M('loans_applylist')->where(['UserID'=>$v['ID']])->getField('LoanStatus');
			if($LoanStatus){
				if($LoanStatus==0){
					$data[$k]['LoanStatus']='申请中';
				}
				if($LoanStatus==1){
					$data[$k]['LoanStatus']='放款中';
				}
				if($LoanStatus==2){
					$data[$k]['LoanStatus']='已放款 ';
				}
				if($LoanStatus==3){
					$data[$k]['LoanStatus']='已完成';
				}
				if($LoanStatus==4){
					$data[$k]['LoanStatus']='已取消';
				}
				if($LoanStatus==5){
					$data[$k]['LoanStatus']='已拒绝';
				}
				if($LoanStatus==6){
					$data[$k]['LoanStatus']='银行打款中';
				}
				if($LoanStatus==7){
					$data[$k]['LoanStatus']='处理中';
				}
				
//				0申请中 1放款中 2已放款 3已完成 4已取消 5人已拒绝6银行打款中7处理中
				
			}else{
				$data[$k]['LoanStatus']='未申请';
			}
	}
	  echo json_encode(array('code'=>'1','data'=>$data));
    }

    /*
     * 获取最新申请订单
    * */
    public function  getnewtime(){
        $ID=M('loans_applylist')->order('ApplyTime desc')->getField('ID');
        echo $ID;
    }

}