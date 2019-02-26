<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/12/26 0026
 * Time: 13:50
 */

namespace Home\Controller;


class SmsController
{
    const S_TABLE='sys_sms';

    public function mingrisms(){
        //获取短信模板sys_smstemplates
        $smscont=M('sys_smstemplates')->where(array('EName'=>'mrhk','Status'=>'1','IsDel'=>'0'))->getField('Content');//明日还款

        $hkStartTime=date("Y-m-d",strtotime("+1 day"));  //按时间查询
        $hkEndTime=date("Y-m-d",strtotime("+2 day"));
        $where['a.YyFkTime']=array('between',$hkStartTime.','.$hkEndTime);
        $where['a.LoanStatus'] = '2';
        $find = M('loans_applylist as a')->field('b.TrueName,b.Mobile,a.OpenTime')
            ->join('xb_mem_info as b on a.UserID=b.id') ->where($where)->select();
//        "【聚鑫贷】尊敬的#name#客户，您于#time#在聚鑫贷借款#money#元，明天是还款日，请您明天登录聚鑫贷APP进行还款，谢谢！";
        foreach ($find as $data){
            $time=date_create($data['OpenTime']);
            $time = date_format($time,"Y-m-d");
            $msg = str_replace("#name#",$data['TrueName'],$smscont);
            $msg = str_replace("#time#",$time,$msg);
            $mobile = $data['Mobile'];
            $result = send_message($mobile,$msg);
            if($result['result']=='success'){
                $data=array("ObjectID"=>$mobile,"Type"=>1,"Mode"=>1,"SendMess"=>$msg,"Status"=>1,"SendTime"=>date("Y-m-d H:i:s"),"Obj"=>2);
                M(self::S_TABLE)->add($data);
            }else{
                $data=array("ObjectID"=>$mobile,"Type"=>1,"Mode"=>1,"SendMess"=>$msg,"Status"=>0,"SendTime"=>date("Y-m-d H:i:s"),"Obj"=>2);
                M(self::S_TABLE)->add($data);
            }
        }
    }
    public function ceshisms(){
        //获取短信模板sys_smstemplates
//        $smscont=M('sys_smstemplates')->where(['EName'=>'mingrihuankuan','Status'=>'1','IsDel'=>'0'])->getField('Content');//商户号

//        $hkStartTime=date("Y-m-d",strtotime("+1 day"));  //按时间查询
//        $hkEndTime=date("Y-m-d",strtotime("+2 day"));
//        $where['a.HkTime']=array('between',$hkStartTime.','.$hkEndTime);
//        $find = M('loans_hklist as a')->field('b.TrueName,b.Mobile,a.TotalMoney,a.JKTime')
//            ->join('xb_mem_info as b on a.UserID=b.id') ->where($where)->select();
////        echo print_r($find);
////        "【聚鑫贷】尊敬的#name#客户，您于#time#在聚鑫贷借款#money#元，明天是还款日，请您明天登录聚鑫贷APP进行还款，谢谢！";
//        foreach ($find as $data){
//            $msg = str_replace("#name#",$data['TrueName'],$smscont);
//            $msg = str_replace("#time#",$data['JKTime'],$msg);
//            $msg = str_replace("#money#",$data['TotalMoney'],$msg);
////            echo $data['Mobile'];
////            echo str_replace("#name#",$data['TrueName'],$smscont);
//            echo $msg;
//            $mobile = $data['Mobile'];
//            echo $mobile;

        //获取短信模板sys_smstemplates
        $smscont=M('sys_smstemplates')->where(array('EName'=>'mrhk','Status'=>'1','IsDel'=>'0'))->getField('Content');//明日还款
        $msg = str_replace("#name#",'鹿聪聪',$smscont);
        $msg = str_replace("#time#",'2018-12-22',$msg);
//            echo $data['Mobile'];
//            $msg = '您好，您的验证码为123456';
        echo $msg;
            $mobile = '17606164656';
            $result = send_message($mobile,$msg);
            print_r($result);
//            echo $result;
//            $result=json_decode($res,true);

            if($result['result']=='success'){
                $data=array("ObjectID"=>$mobile,"Type"=>1,"Mode"=>1,"SendMess"=>$msg,"Status"=>1,"SendTime"=>date("Y-m-d H:i:s"),"Obj"=>2);
                M(self::S_TABLE)->add($data);
                echo "成功";
            }else{
                $data=array("ObjectID"=>$mobile,"Type"=>1,"Mode"=>1,"SendMess"=>$msg,"Status"=>0,"SendTime"=>date("Y-m-d H:i:s"),"Obj"=>2);
                M(self::S_TABLE)->add($data);
                echo "失败";
            }

        }
//    }
}