<?php
/**
 * 功能说明：通用增删改查操作 登录验证
 */
namespace Admin\Controller\System;
use Think\Controller;
class BaseController extends Controller {

    /*
     * 初始化函数，执行任何操作前都会执行
     */
    public function _initialize() {

		//判断数据库链接
		if(!check_mysql()){
			header("Location:http://".$_SERVER['HTTP_HOST']."/remind/1006.html");
			exit();
		}

		//检测登录状态是否过期
		if(empty($_SESSION['AdminInfo']['Admin'])) {
			$this->redirect('System/Login/login');
		}else{
            //如果session不为空，检测登录状态是否过期
            $last_time=strtotime($_SESSION['AdminInfo']['LastLoginTime']);
            $current_time=strtotime(date("Y-m-d H:i:s"));
            $active_time=get_basic_info('Session'); //单位:分钟
            if(($current_time-$last_time)/60>$active_time){
                //已过期重新登录
                session('AdminInfo',null);
                $this->redirect('System/Login/login');
            }else{
                //未过期更新过期时间
                $_SESSION['AdminInfo']['LastLoginTime']=date('Y-m-d H:i:s',time());
            }
        }

		//判断当前是否拥有将要执行的操作的权限
//      if(!is_permission()){
//          //没有权限操作
//          echo "<br/>403错误:<br/>很抱歉，您没有此操作的操作权限！";
//          exit();
//
//      }

        //记录具体的操作日志，排查列表展示等不影响数据变化的操作
        \Think\Hook::add('ActionLog','Admin\\Behavior\\LogBehavior');
        \Think\Hook::listen('ActionLog');
    }

    /**
     * AJAX返回数据标准
     * @param int $status  状态
     * @param string $msg  内容
     * @param mixed $data  数据
     * @param string $dialog  弹出方式
     */
    protected function ajaxReturn($status = 0, $msg = '成功', $data = '', $dialog = '')
    {
        $return_arr = array();
        if (is_array($status)) {
            $return_arr = $status;
        } else {
            $return_arr = array(
                'result' => $status,
                'message' => $msg,
                'des' => $data,
                'dialog' => $dialog
            );
        }
        ob_clean();
        echo json_encode($return_arr);
        exit;
    }

}