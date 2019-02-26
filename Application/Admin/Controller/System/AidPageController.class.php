<?php
/**
 * 功能说明：加编辑按钮
 */
namespace Admin\Controller\System;
use Think\Controller;
class AidPageController extends BaseController {

	const T_OPERATIONBUTTON = 'sys_operationbutton';

	/**
	 * @功能说明：显示图标
	 * @return      [type]                           [description]
	 */
    public function icon(){
		$this->display();
	}

	/**
	 * @功能说明：显示按钮
	 * @return      [type]                           [description]
	 */
	public function menuButton(){
	
	
	
	
		$this->display('System/AidPage/menuButton');
	}

	/**
     * 高德地图
     */
	public function map(){
	    $X=I('request.X');
        $Y=I('request.Y');
        $Name=I('request.Name');
        $this->assign('X',$X);
        $this->assign('Y',$Y);
        $this->assign('Name',$Name);
        $this->display();
    }

}