<?php
/**
 * 富友支付接口
 * Created by PhpStorm.
 * User: xuyuanhua
 * Date: 2017/9/14
 * Time: 09:49
 */

namespace Fuyou;
use Fuyou\Crypt3Des;
use Fuyou\Curl;

class Fuiou
{
    private $config = [];
    private $config_list = [
        'test' => [
            'url_bind_msg' => 'http://www-1.fuiou.com:18670/mobile_pay/newpropay/bindMsg.pay',//短信
            'url_bind_commit' => 'http://www-1.fuiou.com:18670/mobile_pay/newpropay/bindCommit.pay',//绑卡
            'url_newpropay_order' => 'http://www-1.fuiou.com:18670/mobile_pay/newpropay/order.pay',//协议支付  从客户银行卡扣钱
            'merchant' => '0002900F0096235',
            'key' => '5old71wihg2tqjug9kkpxnhx9hiujoqj',
            'parfuyou' => 'https://fht-test.fuiou.com/fuMer/req.do',//给客户付钱
            'jiebang' => 'http://www-1.fuiou.com:18670/mobile_pay/newpropay/unbind.pay',//协议卡解绑


        ],
        'official' => [
             
            'url_bind_msg'=>'https://mpay.fuiou.com/newpropay/bindMsg.pay',
            'url_bind_commit' => 'https://mpay.fuiou.com/newpropay/bindCommit.pay',
            'url_newpropay_order' => 'https://mpay.fuiou.com/newpropay/order.pay',
            'merchant' => '0003310F1852634',
            'key' => 'v75ixbjvrs5j1tf4k4nfdytatq3bvwh0',
            'parfuyou' => 'https://fht.fuiou.com/req.do',
            'jiebang' => 'https://mpay.fuiou.com/newpropay/unbind.pay',//协议卡解绑

        ]
    ];

//  public function __construct($api_type)
//  {
//      $this->config = isset($this->config_list[$api_type])?$this->config_list[$api_type]:[];
//  }

 /**
     * 协议卡解绑接口-协议卡解绑
     * @param $user_id
     * @param $order_no
     * @param $account
     * @param $card_no
     * @param $id_card
     * @param $mobile
     * @param $code
     * @return array
     */
    public function jiebang($merchant,$key,$user_id,$protolno){
        $header = ['Content-Type: application/x-www-form-urlencoded;charset=UTF-8'];
        $VERSION = '1.0';//版本号
        $MCHNTCD = $merchant;//商户号
        $USERID = $user_id;//用户id
        $PROTOCOLNO= $protolno;//首次协议交易成功好生成的协议号
        //待签名数组
        $sign_arr = [$VERSION,$MCHNTCD, $USERID, $PROTOCOLNO,$key];
        $SIGN = md5(implode('|',$sign_arr));
        $APIFMS = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <REQUEST>
        <VERSION>'.$VERSION.'</VERSION>
        <MCHNTCD>'.$MCHNTCD.'</MCHNTCD>
        <USERID>'.$USERID.'</USERID>
        <PROTOCOLNO>'.$PROTOCOLNO.'</PROTOCOLNO>
        <CVN></CVN>
        <SIGN>'.$SIGN.'</SIGN>
        </REQUEST>';
        $key = str_pad($key,64,'D');
        $param['MCHNTCD'] = $merchant;  //商户代码,分配给各合作商户的唯一识别码
        $param['APIFMS'] = Crypt3Des::encrypt_base64($APIFMS,$key);
        $result = Curl::curlPostHttps($this->config_list['official']['jiebang'],$param,$header);
        $xml_result = Crypt3Des::decrypt_base64($result,$key);
        if($xml_result === false){
            $xml_result = $result;
        }
        $arr_result = xmlToArray($xml_result);
        if($arr_result['RESPONSECODE'] == '0000'){
            return ['status'=>1,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }else{
            return ['status'=>0,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }
    }


	/**
     * 协议支付接口
     * @param $user_id
     * @param $order_no
     * @param $user_ip
     * @param $amt
     * @param $protolno
     * @param $back_url
     * @return array
     */
    public function newpropay_order($merchant,$key,$user_id,$order_no,$user_ip,$amt,$protolno,$back_url){
        $header = ['Content-Type: application/x-www-form-urlencoded;charset=UTF-8'];
        $VERSION = '1.0';//版本号
        $USERIP = $user_ip;//客户ip
        $MCHNTCD = $merchant;//商户号
        $TYPE = '03';
        $MCHNTORDERID = $order_no;//商户订单号
        $USERID = $user_id;//用户编号
        $AMT = $amt*100;//金额
        $AMT = $amt;//金额
        $PROTOCOLNO = $protolno;//首次协议交易成功好生成的协议号
        $NEEDSENDMSG  = '0';//是否需要发送短信
        $BACKURL = $back_url;//后台通知URL
        $SIGNTP = 'MD5';
        //待签名数组
        $sign_arr = [$TYPE,$VERSION, $MCHNTCD, $MCHNTORDERID, $USERID, $PROTOCOLNO, $AMT, $BACKURL, $USERIP,$key];
//		p($sign_arr);die;
        $SIGN = md5(implode('|',$sign_arr));
        $APIFMS = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <REQUEST>
        <VERSION>'.$VERSION.'</VERSION>
        <USERIP>'.$USERIP.'</USERIP>
        <MCHNTCD>'.$MCHNTCD.'</MCHNTCD>
        <TYPE>'.$TYPE.'</TYPE>
        <MCHNTORDERID>'.$MCHNTORDERID.'</MCHNTORDERID>
        <USERID>'.$USERID.'</USERID>
        <AMT>'.$AMT.'</AMT>
        <PROTOCOLNO>'.$PROTOCOLNO.'</PROTOCOLNO>
        <NEEDSENDMSG>'.$NEEDSENDMSG.'</NEEDSENDMSG>
        <BACKURL>'.$BACKURL.'</BACKURL>
        <REM1></REM1>
        <REM2></REM2>
        <REM3></REM3>
        <SIGNTP>'.$SIGNTP.'</SIGNTP>
        <SIGN>'.$SIGN.'</SIGN>
        </REQUEST>';
        $key = str_pad($key,64,'D');
        $param['MCHNTCD'] = $merchant;  //商户代码,分配给各合作商户的唯一识别码
        $param['APIFMS'] = Crypt3Des::encrypt_base64($APIFMS,$key);
//		p($param);die;
        $result = Curl::curlPostHttps($this->config_list['official']['url_newpropay_order'],$param,$header);
        $xml_result = Crypt3Des::decrypt_base64($result,$key);
        if($xml_result === false){
            $xml_result = $result;
        }
        $arr_result = xmlToArray($xml_result);
//		p($arr_result);die;
        if($arr_result['RESPONSECODE'] == '0000'){
            $return_data['MCHNTORDERID'] = $arr_result['MCHNTORDERID']; //商户订单号
            $return_data['ORDERID'] = $arr_result['ORDERID']; //富友订单号
            $return_data['PROTOCOLNO'] = $arr_result['PROTOCOLNO']; //协议号
            return ['status'=>1,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$return_data];
        }else{
            return ['status'=>0,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }
    }
	
//	富有代付接口
	public function parfuyou($data){
//		p($data);die;	
		//      xml数据组合
		$ver="1.00";//版本号
		$merdt=date('Ymd');//请求日期
//		$orderno = date('Ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);//请求流水
		$orderno =$data['orderno'];//订单号
		$bankno="0102";//总行代码
		$cityno="1000";//城市代码
		$accntno=$data['accntno'];//用户账号
		$accntnm=$data['accntnm'];//账户名称
		$branchnm=$data['branchnm'];//支行名称
		$amt=$data['amt'];//金额
		$mobile=$data['mobile'];//手机号
		$entseq=$loans_applylist['OrderSn'];//企业流水号
		$memo="备注";//备注
//		P($orderno);DIE;
//		$macsource数据组合
//		$mchntcd="0002900F0345178";//商户号
//		$mchntkey="123456";//秘钥
		$mchntcd=$data['MCHNTCD'];//商户号
//		$mchntkey=$data['mchntkey'];//秘钥
		$mchntkey='v75ixbjvrs5j1tf4k4nfdytatq3bvwh0';//秘钥
		$reqtype="payforreq";//提交方式
		$xml="<?xml version='1.0' encoding='utf-8' standalone='yes'?><payforreq><ver>".$ver."</ver><merdt>".$merdt."</merdt><orderno>".$orderno."</orderno><bankno>".$bankno."</bankno><cityno>".$cityno."</cityno><accntno>".$accntno."</accntno><accntnm>".$accntnm."</accntnm><branchnm>".$branchnm."</branchnm><amt>".$amt."</amt><mobile>".$mobile."</mobile><entseq>".$entseq."</entseq><memo>".$memo."</memo></payforreq>";
		$macsource=$mchntcd."|".$mchntkey."|".$reqtype."|".$xml;
		$mac=md5($macsource);
		$mac=strtoupper($mac);
		$list=array("merid"=>$mchntcd,"reqtype"=>$reqtype,"xml"=>$xml,"mac"=>$mac);
		$url=$this->config_list['official']['parfuyou'];
		$query = http_build_query($list);
		$options = array(
		    'http' => array(
		        'header' => "Content-Type: application/x-www-form-urlencoded\r\n".
		                    "Content-Length: ".strlen($query)."\r\n".
		                    "User-Agent:MyAgent/1.0\r\n",
		        'method'  => "POST",
		        'content' => $query,
		    ),
		);
//		p($options);die;
		$context = stream_context_create($options);
		$result = file_get_contents($url, false, $context, -1, 40000);
		$result=xmlToArray($result);//返回xml数据转数组
//		p($result);exit;
		if($result['ret']==000000){
			return ['status'=>1,'msg'=>$result['memo'],'data'=>$result];
        }else{
			return ['status'=>0,'msg'=>$result['memo'],'data'=>$result];
        }
	}

    /**
     * 协议卡绑定接口-发送短信验证码接口
     * @param $merchant  @商户号
     * @param $key  @秘钥
     * @param $user_id  @用户编号
     * @param $order_no @商户流水号
     * @param $account  @账户名称
     * @param $card_no  @银行卡号
     * @param $id_card  @证件号码
     * @param $mobile   @手机号码
     * @return array
     */
    public function bind_msg($merchant,$key,$user_id,$order_no,$account,$card_no,$id_card,$mobile){   	
        $header = ['Content-Type: application/x-www-form-urlencoded;charset=UTF-8'];
        $VERSION = '1.0';
        $MCHNTCD = $merchant;
        $USERID = $user_id;
        $TRADEDATE = date('Ymd');
        $MCHNTSSN = $order_no;
        $ACCOUNT = $account;
        $CARDNO = $card_no;
        $IDTYPE = '0';
        $IDCARD = $id_card;
        $MOBILENO = $mobile;
        //待签名数组
        $sign_arr = [$VERSION, $MCHNTSSN, $MCHNTCD, $USERID, $ACCOUNT, $CARDNO, $IDTYPE, $IDCARD, $MOBILENO,$key];
//		p($sign_arr);die;
        $SIGN = md5(implode('|',$sign_arr));
        $APIFMS = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <REQUEST>
        <VERSION>'.$VERSION.'</VERSION>
        <MCHNTCD>'.$MCHNTCD.'</MCHNTCD>
        <USERID>'.$USERID.'</USERID>
        <TRADEDATE>'.$TRADEDATE.'</TRADEDATE>
        <MCHNTSSN>'.$MCHNTSSN.'</MCHNTSSN>
        <ACCOUNT>'.$ACCOUNT.'</ACCOUNT>
        <CARDNO>'.$CARDNO.'</CARDNO>
        <IDTYPE>'.$IDTYPE.'</IDTYPE>
        <IDCARD>'.$IDCARD.'</IDCARD>
        <MOBILENO>'.$MOBILENO.'</MOBILENO>
        <CVN></CVN>
        <SIGN>'.$SIGN.'</SIGN>
        </REQUEST>';
        $key = str_pad($key,64,'D');	
        $param['MCHNTCD'] = $merchant;  //商户代码,分配给各合作商户的唯一识别码
        $param['APIFMS'] = Crypt3Des::encrypt_base64($APIFMS,$key);
//      p($param);
		
//		p($this->config_list['official']['url_bind_msg']);die;
        $result = Curl::curlPostHttps($this->config_list['official']['url_bind_msg'],$param,$header);
        $xml_result = Crypt3Des::decrypt_base64($result,$key);
        if($xml_result === false){
            $xml_result = $result;
        }
        $arr_result = xmlToArray($xml_result);
//		p($arr_result);die;
        if($arr_result['RESPONSECODE'] == '0000'){
			return ['status'=>1,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }else{
			return ['status'=>0,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }
    }

    /**
     * 协议卡绑定接口-协议卡绑定
     * @param $user_id
     * @param $order_no
     * @param $account
     * @param $card_no
     * @param $id_card
     * @param $mobile
     * @param $code
     * @return array
     */
    public function bind_commit($merchant,$key,$user_id,$order_no,$account,$card_no,$id_card,$mobile,$code){
        $header = ['Content-Type: application/x-www-form-urlencoded;charset=UTF-8'];
        $VERSION = '1.0';
        $MCHNTCD = $merchant;
        $USERID = $user_id;
        $TRADEDATE = date('Ymd');
        $MCHNTSSN = $order_no;
        $ACCOUNT = $account;
        $CARDNO = $card_no;
        $IDTYPE = '0';
        $IDCARD = $id_card;
        $MOBILENO = $mobile;
        $MSGCODE = $code;
        //待签名数组
        $sign_arr = [$VERSION, $MCHNTSSN, $MCHNTCD, $USERID, $ACCOUNT, $CARDNO, $IDTYPE, $IDCARD, $MOBILENO,$MSGCODE,$key];
        $SIGN = md5(implode('|',$sign_arr));
        $APIFMS = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <REQUEST>
        <VERSION>'.$VERSION.'</VERSION>
        <MCHNTCD>'.$MCHNTCD.'</MCHNTCD>
        <USERID>'.$USERID.'</USERID>
        <TRADEDATE>'.$TRADEDATE.'</TRADEDATE>
        <MCHNTSSN>'.$MCHNTSSN.'</MCHNTSSN>
        <ACCOUNT>'.$ACCOUNT.'</ACCOUNT>
        <CARDNO>'.$CARDNO.'</CARDNO>
        <IDTYPE>'.$IDTYPE.'</IDTYPE>
        <IDCARD>'.$IDCARD.'</IDCARD>
        <MOBILENO>'.$MOBILENO.'</MOBILENO>
        <MSGCODE>'.$MSGCODE.'</MSGCODE>
        <CVN></CVN>
        <SIGN>'.$SIGN.'</SIGN>
        </REQUEST>';
        $key = str_pad($key,64,'D');
        $param['MCHNTCD'] = $merchant;  //商户代码,分配给各合作商户的唯一识别码
        $param['APIFMS'] = Crypt3Des::encrypt_base64($APIFMS,$key);
//		p($param);die;
        $result = Curl::curlPostHttps($this->config_list['official']['url_bind_commit'],$param,$header);
        $xml_result = Crypt3Des::decrypt_base64($result,$key);
        if($xml_result === false){
            $xml_result = $result;
        }
        $arr_result = xmlToArray($xml_result);
//		p($arr_result);die;
        if($arr_result['RESPONSECODE'] == '0000'){
            return ['status'=>1,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }else{
            return ['status'=>0,'msg'=>$arr_result['RESPONSEMSG'],'data'=>$arr_result];
        }
    }


    
}