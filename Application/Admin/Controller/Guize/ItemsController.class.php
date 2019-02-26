<?php
/**
 * 功能说明: 后台规则配置
 */
 namespace Admin\Controller\Guize;
 
 use Admin\Controller\System\BaseController;
// use XBCommon;
 class ItemsController extends BaseController{
// 雷达规则配置(可信任)
    public function leida(){
     if($_POST){
	         $data=$_POST;
//	var_dump($data);die;
	     	 $re=M('ss_guize_leida')->where(array('id'=>'1'))->save($data);
			 if($re){
//			    
                $leidadate=M('ss_guize_leida')->where(array('id'=>'1'))->find();
			 }else{
//			 	这个给一个错误提示
			 	$leidadate=M('ss_guize_leida')->find();
			 }
		}else{
          $leidadate=M('ss_guize_leida')->find();
		}
//p($leidadate);die;

		$this->assign('guize',$leidadate);
        $this->display('Guize/Items/help');
     }
	 
	 
	 
	 
	  public function xibai(){
         $this->display();
     }
	   public function lahei(){
         $this->display();
     }
	    public function youdun(){
         $this->display();
     }

     
 }