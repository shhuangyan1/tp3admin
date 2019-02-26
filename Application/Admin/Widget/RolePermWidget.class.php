<?php
/**
 * 功能说明：模板权限控制
 */
namespace Admin\Widget;
use Think\Controller;
use XBCommon;

class RolePermWidget extends Controller{

	/**
	 * 组装操作按钮权限控制（头部）
	 */
	public function RolePermTop() {
	    if(ACTION_NAME=='lists' || ACTION_NAME=='list'){
            $EnName = CONTROLLER_NAME . "/index";
        }else{
            $EnName = CONTROLLER_NAME . "/" . ACTION_NAME;
        }
        $cache=new XBCommon\CacheData();
        $list=$cache->RoleMenu($EnName);
		$this->assign("list",$list);
		$this->display('RolePerm/RolePermTop');
	}

	/**
	 * 组装操作按钮的js(底部)
	 */
	public function RolePermBottom() {
		//根据控制器名称获取相应的菜单名称
        if(ACTION_NAME=='lists' || ACTION_NAME=='list'){
            $EnName = CONTROLLER_NAME . "/index";
        }else{
            $EnName = CONTROLLER_NAME . "/" . ACTION_NAME;
        }
        $cache=new XBCommon\CacheData();
        $str=$cache->RoleBottom($EnName);
		echo $str;
	}
}
