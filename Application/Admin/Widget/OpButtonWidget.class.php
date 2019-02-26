<?php
/**
 * 功能说明：按钮显示挂件
 */
namespace Admin\Widget;
use Think\Controller;

class OpButtonWidget extends Controller{
	public function OpButton() {
		$nav_list = M("sys_operationbutton")->where(array('IsDel'=>0,'Status'=>1))->order('Sort ASC')->select();
//        foreach ($nav_list as $val){
//            var_dump($val['Sort']);
//        }
//       exit;
		$this->assign("nav_list",$nav_list);
		$this->display('OpButton/OpButton');
	}
}
