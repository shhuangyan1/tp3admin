<?php
/**
 * 功能说明: 注册控制器
 */
 
 namespace Home\Controller;

 class RegisterController extends HomeController{

     const T_TABLE='mem_info';
     //注册页面
     public function index(){
         $referee=$_GET['ui'];
         if( $referee ){
             $this->assign('referee',$referee);
         }
         $this->display();
     }

     //渠道推广注册页面
     public function tuiguang(){
        $puser=I('get.puser','');
        $this->assign(array(
            'puser'=>$puser,
            ));
        $this->display();
     }

     /*
      * 后台处理ajax传递的数据
      */
     public function ajaxRegister(){
         if(!IS_POST){
             $this->ajaxReturn(0,"数据传递方式错误！");
         }
         $Mobile = I("post.Mobile",'',"trim");
         $Password = I("post.Password",'',"trim");
         $MsgCode = I("post.MsgCode",'',"trim");

         //校验手机号
         if(!$Mobile){
             $this->ajaxReturn(0,"请填写手机号码");
         }

         if (!is_mobile($Mobile)) {
             $this->ajaxReturn(0,"手机号码格式不正确！");
         }
         $exit=M('mem_info')->where(array('IsDel'=>0,'Mobile'=>$Mobile))->count('ID');
         if($exit){
             $this->ajaxReturn(0,"该手机号码已注册过会员，不能重复使用！");
         }

         //校验短信验证码
         if(!$MsgCode){
             $this->ajaxReturn(0,"请输入短信验证码");
         }
         $Ccodes = M('sms_code')->where(array("Name" => $Mobile))->getField('Code');
         if ($Ccodes <> $MsgCode) {
             $this->ajaxReturn(0, "手机验证码错误，请重新输入!");
         }
         //校验密码
         if(!$Password){
             $this->ajaxReturn(0,"请输入您的密码");
         }
         if (strlen($Password)<6) {
             $this->ajaxReturn(0,"密码必须是6位以上数字的组合");
         }

         $data = array(
             "NickName" => $Mobile,
             "UserName" => $Mobile,
             "TrueName" => substr($Mobile,-4),
             "Password" => getGroupMd5($Password),
             "Mobile" => $Mobile,
             "RegTime" => date("Y-m-d H:i:s"),
             'Tjcode'=>$Mobile,
             'Retype'=>'0',
         );

         //推荐人的id
         $Referee=I('post.Referee',0,'intval');
         if($Referee){
             $exit_refer=M('mem_info')->where( array('ID'=>$Referee,'IsDel'=>0) )->count('ID');
             if($exit_refer){
                 $data['Referee']=$Referee;
             }
         }
         //渠道推广
         $puser=$_POST['puser'];
         if($puser){
             $TgadminID=M('tg_admin')->where(array('UserName'=>$puser,'Status'=>'1','IsDel'=>'0'))->getField('ID');
             if($TgadminID){
                 $data['TgadminID']=$TgadminID;
             }
         }
         $result = M('mem_info')->add($data);
         if ($result) {
            //更新 会员账号(UID_ID)  字段
             M('mem_info')->where(array('ID'=>$result))->save(array('MemAccount'=>'UID_'.$result));
             M('sms_code')->where(array("Name" => $Mobile))->delete();
             send_mem_notics($result,"欢迎成为本站会员，请妥善保管自己的账号。");
             self_sendjuan($result,'1');//注册成功立送
             if($Referee){
                self_sendjuan($result,'3');//每邀请1名好友注册立送
             }
             $this->ajaxReturn(1,"注册成功!");
         } else {
             $this->ajaxReturn(0,"注册失败!");
         }
     }
    //注册协议
     public function regdetail(){
        $infos=M('sys_contentmanagement')->field('Contents')->where(array('CategoriesID'=>'8'))->find();
        $infos['Contents']=htmlspecialchars_decode($infos['Contents']);
        $this->assign(array(
            'infos'=>$infos,
            ));
        $this->display();
     }
     //------------------------------函数测试
     public function jsceshi(){
        // $aa=selfpromotes(10);
        // var_dump($aa);exit;
     }

 }
 