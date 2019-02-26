<?php
/**
 * 功能说明: 公共控制器
 */

namespace Home\Controller;
use Think\Controller;
use XBCommon\XBCache;
use XBCommon;
class CommonController extends HomeController
{
    const S_TABLE='sys_sms';
    const C_TABLE='sms_code';

    /**
     * 生成验证码
     */
    public function selfverify(){
        $config =    array(
            'fontSize'    =>    30,    // 验证码字体大小
            'length'      =>    4,     // 验证码位数
            'useNoise'    =>    false, // 关闭验证码杂点
        );
        $Verify =     new \Think\Verify($config);
        $Verify->codeSet = '0123456789';
        ob_end_clean();
        $Verify->entry();
    }

    /**
     * 地址拦截
     * @param $reange
     */
    public function reange($reange){
        switch ($reange){
            case '江苏';
                break;
            case '浙江';
                break;
            case '上海';
                break;
            case '安徽';
                break;
            case '山东';
                break;
            case '湖南';
                break;
            case '湖北';
                break;
            case '江西';
                break;
            case '福建';
                break;
            case '山西';
                break;
            case '陕西';
                break;
            case '北京';
                break;
            case '天津';
                break;
            case '河北';
                break;
            case '广东';
                break;
            case '广西';
                break;
            case '重庆';
                break;
            case '四川';
                break;
            case '黑龙江';
                break;
            case '吉林';
                break;
            case '辽宁';
                break;
            default:
//                $this->ajaxReturn(0,"很抱歉，您所在的地区不支持注册！");
                $this->ajaxReturn(0,"很抱歉，您的号码识别失败！");
                break;

        }
    }

    /**
     * 获取手机验证码
     */
    public function getcode(){

        $mobile = I("post.mobile",'','trim');
        $check=I("post.check",'','trim');
        $yzm = I("post.code",'','trim');//图形验证码

        //尝试在cookie里取手机号码
        if(!$mobile){
            $mobile=cookie('checkArr')['m'];
        }

        if(!$mobile){
            $this->ajaxReturn(0,'手机号不能为空');
        }elseif(!is_mobile($mobile)){
            $this->ajaxReturn(0,'手机号格式不正确');
        }

        $mobile7 = substr($mobile , 0 , 7);
        $reange = M('mobile_range')->where(array('prefix'=>$mobile7))->getField('provice');
        if($reange){
            $this->reange($reange);
        }else{
            $apiurl = 'http://apis.juhe.cn/mobile/get';
            $params = array(
                'key' => 'b4b88a8ffc09e2fd3f24251ee19fa168', //您申请的手机号码归属地查询接口的appkey b4b88a8ffc09e2fd3f24251ee19fa168
                'phone' => $mobile //要查询的手机号码
            );
            $paramsString = http_build_query($params);
            $content = @file_get_contents($apiurl.'?'.$paramsString);
            $result = json_decode($content,true);
            $this->ajaxReturn(0,$content);
            if($result['error_code'] == '0'){
                /*
                "province":"浙江",
                "city":"杭州",
                "areacode":"0571",
                "zip":"310000",
                "company":"中国移动",
                "card":"移动动感地带卡"
                */
                $this->reange($result['result']['province']);
            }else{
//                echo $result['reason']."(".$result['error_code'].")";
                $this->ajaxReturn(0,"很抱歉，您所在的地区不支持注册！！");
            }
//             $this->ajaxReturn(0,"很抱歉，您所在的地区不支持注册！");
        }

        if($yzm){
            $verify = new \Think\Verify();
            $res = $verify->check($yzm);
            if(!$res){
                $this->ajaxReturn(0,"图形验证码不正确，请重新输入!");
            }
        }


        if($check==1){  //注册验证身份
            $where['Mobile']=$mobile;
            $where['IsDel']=0;
            $find = M('mem_info')->field('ID')->where($where)->find();
            if($find){
                $this->ajaxReturn(0,"该手机号码已注册过会员，不能重复使用！");
            }
        }


        $code=rand(000000,999999);
        $msg="尊敬的用户，您已通过手机验证，验证码：".$code;

        // $message = new \XBCommon\XBMessage($mobile,$msg);
        // $res = $message->send_message();
        // if(!$res){
        //     $this->ajaxReturn(0,'发送短信异常，请稍后重试！');
        // }
        $result = send_message($mobile,$msg);

        //$result=json_decode($res,true);
        if($result['result']=='success'){
            $data=array("ObjectID"=>$mobile,"Type"=>1,"Mode"=>1,"SendMess"=>$msg,"Status"=>1,"SendTime"=>date("Y-m-d H:i:s"),"Obj"=>1);
            M(self::S_TABLE)->add($data);

            $res=M(self::C_TABLE)->where(array("Name"=>$mobile,"Type"=>0))->find();
            if($res){
                M(self::C_TABLE)->where(array("Name"=>$mobile))->save(array("Code"=>$code,"UpdateTime"=>date("Y-m-d H:i:s")));
            }else{
                $datas=array("Name"=>$mobile,"Type"=>0,"Code"=>$code,"UpdateTime"=>date("Y-m-d H:i:s"));
                M(self::C_TABLE)->add($datas);
            }
            cookie('yzm',array('yzm'=>$yzm),0);
            $this->ajaxReturn(1,'发送成功,请注意查收！');
        }else{
            $this->ajaxReturn(0,'发送失败,请重新尝试！');
        }
    }

    public function getImgCode(){
        $config =    array(
            'fontSize'    =>    30,    // 验证码字体大小
            'length'      =>    4,     // 验证码位数
            'useNoise'    =>    false, // 关闭验证码杂点
        );
        $Verify =     new \Think\ImgCode($config);
        $Verify->codeSet = '0123456789';
        ob_end_clean();
        $Verify->entry();
    }

}