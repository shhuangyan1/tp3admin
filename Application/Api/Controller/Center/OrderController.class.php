<?php

namespace Api\Controller\Center;

use Api\Controller\Core\BaseController;
use XBCommon\XBCache;
use Fuyou\Fuiou;

class OrderController extends BaseController
{
    const T_MEMINFO = 'mem_info';
    const T_GOODS = 'goods';
    const T_MEMCOUPANS = 'mem_coupans';
    const T_CONTENTMANAGEMENT = 'sys_contentmanagement';
    const T_LOANSAPPLYLIST = 'loans_applylist';
    const T_LOANSXJAPPLYLIST = 'loans_xjapplylist';
    const T_LOANSPARAMETER = 'loans_parameter';//贷款参数设置
    const T_LOANSHKLIST = 'loans_hklist';

    public function _initialize()
    {
        parent::_initialize();
        $this->statusArr = array(
            '0' => '申请中',
            '1' => '放款中',//放款中
            '2' => '已放款',//已放款
            '3' => '已完成',
            '4' => '已取消',
            '5' => '已拒绝',
        );
    }

    /**
     * @功能说明: 立即借款校验(首页立即借款)
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/fastbuycheck
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"0"}
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function fastbuycheck()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $retdata = array(
            'status' => '1',
            'msg' => '可以借款',
        );
        $meminfos = M(self::T_MEMINFO)->field('ForbidTime,Status,LimitBalcance')->find($mem['ID']);

        //判断是否认证，
        if ($meminfos['Status'] == '1') {
            $retdata['status'] = '0';
            $retdata['jumps'] = '2';
            $retdata['msg'] = '您还没有认证，请先去认证！';
            AjaxJson(0, 1, '您还没有认证，请先去认证！', $retdata, 1, $mem['KEY'], $mem['IV']);
        }
        //校验必须认证
        $checkflags = checkmust_renz($mem['ID']);
        if (!$checkflags) {
            $retdata['status'] = '0';
            $retdata['msg'] = '必须认证未认证完，请先去认证！';
            AjaxJson(0, 1, '必须认证未认证完，请先去认证！', $retdata, 1, $mem['KEY'], $mem['IV']);
        }
        //校验会员年龄有没有达到借款条件
        $membirthday = M('renzen_cards')->where(array('UserID' => $mem['ID'], 'Status' => '1', 'IsDel' => '0'))->getField('Birthday');
        if ($membirthday) {
            $membirthday = strtotime($membirthday);
            $memage = getage($membirthday);
            $MaxAges = get_basic_info('MaxAges');
            $MinAges = get_basic_info('MinAges');
            if ($memage < $MinAges || $memage > $MaxAges) {
                $err = '';
                AjaxJson(0, 0, '抱歉，您的年龄不符合条件！', $err, 1, $mem['KEY'], $mem['IV']);
            }
        }

        if (in_array($meminfos['Status'], array('3', '4'))) {
            $err = '';
            AjaxJson(0, 0, '您没有购买权限！', $err, 1, $mem['KEY'], $mem['IV']);
        }
        if ($meminfos['ForbidTime'] && $meminfos['ForbidTime'] > date('Y-m-d H:i:s')) {
            $retdata['status'] = '0';
            $retdata['ForbidTime'] = strtotime($meminfos['ForbidTime']) - time();
            $retdata['msg'] = $meminfos['ForbidTime'] . '之前，暂不能下单!';
        }
        //判断是否有未结束的 借款订单
        $orderinfos = M(self::T_LOANSAPPLYLIST)->where(array('UserID' => $mem['ID'], 'LoanStatus' => array('in', array('0', '1', '2', '5', '6', '7')), 'IsDel' => '0'))->count('ID');
        if ($orderinfos) {
            $retdata['status'] = '0';
            $retdata['jumps'] = '1';
            $retdata['msg'] = '还有未完成的订单，暂不能下单!';
        }
        AjaxJson(0, 1, '恭喜您，数据校验成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 获取借款金额与借款期限(我要借贷)
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/getjkparater
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"0"}
     *   gid 商品详情id
     * @返回信息: {'result'=>1,'message'=>'数据获取成功!'}
     */
    public function getjkparater()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        $LimitBalcance = M(self::T_MEMINFO)->where(array('ID' => $mem['ID']))->getField('LimitBalcance');


        //获取借款金额
        $moneylist = M(self::T_GOODS)->field('ID,SalePrice,Interest,Fastmoney,GuanliCost,CashCoupon')->where(array('SalePrice' => array('ELT', $LimitBalcance), 'IsShelves' => '1', 'IsDel' => '0'))->order('Sort asc,ID desc')->select();
        //获取借款期限
        $termlist = M('loans_term')->field('ID,NumDays,Applyfee,Fastmoney,GuanliCost')->where(array('Status' => '1', 'IsDel' => '0'))->order('Sort asc,ID desc')->select();
        $retdata = array(
            'moneylist' => $moneylist,
            'termlist' => $termlist,
        );

//	    p($retdata);die;
        AjaxJson(1, 1, '恭喜您，数据校验成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 到期应还金额(我要借贷)
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/gethkmoney
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"gid":"2","termid":"2","juanid":"2"}}
     *   gid 借款金额id   termid 借款期限id juanid 优惠劵id
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function gethkmoney()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        if (!$para['gid']) {
            AjaxJson(0, 0, '请选择借款金额！');
        }
        if (!$para['termid']) {
            AjaxJson(0, 0, '请选择借款期限！');
        }
        $LimitBalcance = M(self::T_MEMINFO)->where(array('ID' => $mem['ID']))->getField('LimitBalcance');
        $goodinfo = M(self::T_GOODS)->field('ID,SalePrice,Interest,CashCoupon')->where(array('ID' => $para['gid'], 'SalePrice' => array('ELT', $LimitBalcance), 'IsShelves' => '1', 'IsDel' => '0'))->find();
        if (!$goodinfo) {
            AjaxJson(0, 0, '借款金额信息异常！');
        }
        $terminfo = M('loans_term')->field('ID,Applyfee')->where(array('ID' => $para['termid'], 'Status' => '1', 'IsDel' => '0'))->find();
        if (!$terminfo) {
            AjaxJson(0, 0, '借款期限信息异常！');
        }
        //优惠劵信息校验
        if ($para['juanid'] != '0') {
            if ($goodinfo['CashCoupon'] == '2') {
                AjaxJson(0, 0, '此借款金额不能使用优惠劵！');
            }
            $coupaninfo = M(self::T_MEMCOUPANS)->field('ID,StartMoney,StartTime,Money')->where(array('ID' => $para['juanid'], 'UserID' => $mem['ID'], 'Isuser' => '1', 'IsDel' => '0', 'EndTime' => array('EGT', date('Y-m-d H:i:s'))))->find();
            if (!$coupaninfo) {
                AjaxJson(0, 0, '优惠劵信息异常！');
            }
            if ($goodinfo['SalePrice'] < $coupaninfo['StartMoney']) {
                AjaxJson(0, 0, '此借款金额不符合此优惠劵使用条件！');
            }
            if ($coupaninfo['StartTime'] > date('Y-m-d H:i:s')) {
                AjaxJson(0, 0, '此优惠劵暂不能使用！');
            }
        }
        //到期应还金额
        $hkmoney = '0';
        if ($coupaninfo) {
            $hkmoney = $goodinfo['SalePrice'] - $coupaninfo['Money'] + $goodinfo['Interest'] + $terminfo['Applyfee'];
        } else {
            $hkmoney = $goodinfo['SalePrice'] + $goodinfo['Interest'] + $terminfo['Applyfee'];
        }
        $retdata = array(
            'hkmoney' => $hkmoney,
        );
        AjaxJson(0, 1, '恭喜您，数据校验成功！', $retdata);
    }
//	扣款函数
//$status  功能id
//1 身份认证
//2银行卡认证
//3基本信息认证
//4社交认证
//5支付宝认证
//6手机认证
//7淘宝认证
    public function koukuan($status = '0')
    {
//	    $url = "http://php.51xjsd.com/admin.php/admin/login/koukuan";//连接地址
//		$username='123456';//账号
//		$password='123456';//密码
//		$password=md5($password);
//   	$data=$this->mmma($username,$password);
//		$data['status']=$status;
////		p($data);
//		$re=httpPost($data, $url);
//		$re=json_decode($re,1);
////		p($re);
//      if($re['status']!==1){
//			AjaxJson(0,0,'系统错误 ，请联系官方');
//      }
        return TRUE;
    }

    ///  生成token
    public function mmma($username, $password)
    {
        $data['username'] = $username;
        $data['password'] = $password;
        $data['token'] = md5($username . md5($password));
        return $data;
    }

    //	雷达
    public function xinyan($datainfo)
    {
// 	 	$re=$this->koukuan(8);//扣款创建订单
        if (!$re) {
            AjaxJson(0, 0, '系统错误 ，请联系官方');
        }
        $url = 'http://app.51xjsd.cn/Radar-report/controllers/CreditRadarController.php';
        $data['urlType'] = 'json';//版本号
        $data['versions'] = '1.3.0';//版本号
        $data['url'] = 'https://api.xinyan.com/product/radar/v3/report';//版本号
        $data['id_no'] = $datainfo['id_no'];//被查询人身份证号
        $data['id_name'] = $datainfo['id_name'];//姓名
        $data['phone_no'] = $datainfo['phone_no'];//手机号
        $data['bankcard_no'] = $datainfo['bankcard_no'];//银行卡号
        $re = httpPost($data, $url);
        $re = json_decode($re, 1);
//		p($re);die;
        return $re;
    }

// 负面洗白
    public function fumianxibai($datainfo)
    {
//  	$re=$this->koukuan(10);//扣款创建订单
        if (!$re) {
            AjaxJson(0, 0, '系统错误 ，请联系官方');
        }
        $url = 'http://app.51xjsd.cn/Radar-report/controllers/CreditRadarController.php';
        $data['urlType'] = 'json';//版本号
        $data['versions'] = '1.3.0';//版本号
        $data['url'] = 'https://api.xinyan.com/product/negative/v3/white';//版本号
//		$data['id_no']='340822199206114339';//被查询人身份证号

        $data['id_no'] = $datainfo['id_no'];//被查询人身份证号
        $data['id_name'] = $datainfo['id_name'];//姓名
        $data['phone_no'] = $datainfo['phone_no'];//手机号
        $data['bankcard_no'] = $datainfo['bankcard_no'];//银行卡号
        $re = httpPost($data, $url);
        $re = json_decode($re, 1);
        return $re;

    }

// 负面拉黑
    public function fumianlahei($datainfo)
    {
//  	$re=$this->koukuan(10);//扣款创建订单
        if (!$re) {
            AjaxJson(0, 0, '系统错误 ，请联系官方');
        }

        $url = 'http://app.51xjsd.cn/Radar-report/controllers/CreditRadarController.php';
        $data['urlType'] = 'json';//版本号
        $data['versions'] = '1.3.0';//版本号
        $data['url'] = 'https://api.xinyan.com/product/negative/v3/black';//版本号
//		$data['id_no']='340822199206114339';//被查询人身份证号

        $data['id_no'] = $datainfo['id_no'];//被查询人身份证号
        $data['id_name'] = $datainfo['id_name'];//姓名
        $data['phone_no'] = $datainfo['phone_no'];//手机号
        $data['bankcard_no'] = $datainfo['bankcard_no'];//银行卡号
        $re = httpPost($data, $url);
        $re = json_decode($re, 1);
        return $re;

    }


    /**
     * @功能说明: 提交订单操作(我要借贷)  安卓
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/downorder
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"gid":"2","termid":"2","juanid":"2"}}
     *   gid 借款金额id   termid 借款期限id juanid 优惠劵id
     * @返回信息: {'result'=>1,'message'=>'数据获取成功!'}
     */
    public function downorder()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));

        $ressssss = M('loans_applylist')->where(array('UserID' => $mem['ID'], 'LoanStatus' => '6'))->find();
        if ($ressssss) {
            AjaxJson(0, 0, '有正在执行的订单 ，请勿重复提交');//判断是否有正在等待银行打款的订单
        }
        $ressssss = M('loans_applylist')->where(array('UserID' => $mem['ID'], 'LoanStatus' => '7'))->find();
        if ($ressssss) {
            AjaxJson(0, 0, '有正在执行的订单 ，请及时联系客服');//判断是否有正在等待银行打款的订单
        }
        $ressssss = M('loans_applylist')->where(array('UserID' => $mem['ID'], 'LoanStatus' => '5'))->find();
        if ($ressssss) {
            AjaxJson(0, 0, '抱歉！您的审核未通过！');//判断是否有正在等待银行打款的订单
        }
//		$datainfo['id_no']=$mem['IDCard'];//被查询人身份证号
//		$datainfo['id_name']=$mem['TrueName'];//姓名
//		$datainfo['phone_no']=$mem['Mobile'];//手机号
//		$xinyanar=$this->xinyan($datainfo);//调用雷达  数据入库
//		$xinyan=json_encode($xinyanar,1);
//		$xinyanbagao['UserID']=$mem['ID'];
//		$xinyanbagao['status']='1';
//		$xinyanbagao['data']=$xinyan;
//		$xinyanbagao['create_time']=date('Y-m-d h:i:s',time());
//		$dateleida=M('ss_bgdata')->where(['UserID'=>$mem['ID'],'status'=>1])->find();
//		if($dateleida){
//			$xinyanbagao['update_time']=date('Y-m-d h:i:s',time());
//			$aa=M('ss_bgdata')->where(['ID'=>$dateleida['ID']])->save($xinyanbagao);
//			if(!$aa){
//				 AjaxJson(0,0,'新颜雷达资信数据更新失败,申请提交失败！');//ss
//			}
//		}else{
//		   $leidaid=M('ss_bgdata')->add($xinyanbagao);
//		   if(!$leidaid){
//				 AjaxJson(0,0,'新颜雷达资信数据保存失败,申请提交失败！');//ss
//			}
//	   }
//		负面洗白数据入库
//		$fumianxibaiar=$this->fumianxibai($datainfo);
//	    $fumianxibai=json_encode($fumianxibaiar,1);
//		p($fumianxibai);
//		$fumianxibaibaogao['UserID']=$mem['ID'];
//		$fumianxibaibaogao['status']='2';
//		$fumianxibaibaogao['data']=$fumianxibai;
//		$fumianxibaibaogao['create_time']=date('Y-m-d h:i:s',time());
//		$datexibai=M('ss_bgdata')->where(['UserID'=>$mem['ID'],'status'=>2])->find();
//		if($datexibai){
//			$fumianxibaibaogao['update_time']=date('Y-m-d h:i:s',time());
//			$bb=M('ss_bgdata')->where(['ID'=>$datexibai['ID']])->save($fumianxibaibaogao);
//			if(!$bb){
//
//				 AjaxJson(0,0,'新颜负面洗白资信数据更新失败,申请提交失败！');//ss
//			}
//		}else{
//		  $xibaiid=M('ss_bgdata')->add($fumianxibaibaogao);
//		  if(!$xibaiid){
//				 AjaxJson(0,0,'新颜负面洗白资信数据保存失败,申请提交失败！');//ss
//			}
//		}
//		负面拉黑数据入库
//		$fumianlaheiar=$this->fumianlahei($datainfo);
//	    $fumianlahei=json_encode($fumianlaheiar,1);
//		p($fumianlahei);
//		$fumianlaheibaogao['UserID']=$mem['ID'];
//		$fumianlaheibaogao['status']='3';
//		$fumianlaheibaogao['data']=$fumianlahei;
//		$fumianlaheibaogao['create_time']=date('Y-m-d h:i:s',time());
//		$datelahei=M('ss_bgdata')->where(['UserID'=>$mem['ID'],'status'=>3])->find();
//		p($datelahei);
//		if($datelahei){
//			$fumianlaheibaogao['update_time']=date('Y-m-d h:i:s',time());
//			$cc=M('ss_bgdata')->where(['ID'=>$datelahei['ID']])->save($fumianlaheibaogao);
//			if(!$cc){
//				 AjaxJson(0,0,'新颜负面拉黑资信数据更新失败,申请提交失败！');//ss
//			}
//		}else{
//		  $xibaiid=M('ss_bgdata')->add($fumianlaheibaogao);
//		  if(!$xibaiid){
//				 AjaxJson(0,0,'新颜负面拉黑资信数据保存失败,申请提交失败！');//ss
//			}
//		}
        //校验
        if (!$para['gid']) {
            AjaxJson(0, 0, '请选择借款金额！');
        }
        if (!$para['termid']) {
            AjaxJson(0, 0, '请选择借款期限！');
        }
        //校验 是否有借款的条件
        $rtdata = checkmembuy($mem['ID']);
        if ($rtdata['result'] == '0') {
            AjaxJson(0, 0, $rtdata['message']);
        }
        //校验必须认证
        $checkflags = checkmust_renz($mem['ID']);
        if (!$checkflags) {
            AjaxJson(0, 0, '必须认证未认证完，请先去认证！');
        }
        //校验会员年龄有没有达到借款条件
        $membirthday = M('renzen_cards')->where(array('UserID' => $mem['ID'], 'Status' => '1', 'IsDel' => '0'))->getField('Birthday');
        if ($membirthday) {
            $membirthday = strtotime($membirthday);
            $memage = getage($membirthday);
            $MaxAges = get_basic_info('MaxAges');
            $MinAges = get_basic_info('MinAges');
            if ($memage < $MinAges || $memage > $MaxAges) {
                AjaxJson(0, 0, '抱歉，您的年龄不符合条件！');
            }
        }
        //获取会员的借款额度
        $LimitBalcance = M(self::T_MEMINFO)->where(array('ID' => $mem['ID']))->getField('LimitBalcance');
//		P($LimitBalcance);
        $goodinfo = M(self::T_GOODS)->field('ID,SalePrice,Interest,Fastmoney,GuanliCost,CashCoupon')->where(array('ID' => $para['gid'], 'SalePrice' => array('ELT', $LimitBalcance), 'IsShelves' => '1', 'IsDel' => '0'))->find();
        if (!$goodinfo) {
            AjaxJson(0, 0, '借款金额信息异常！');
        }
        $terminfo = M('loans_term')->field('ID,NumDays,Applyfee,Fastmoney,GuanliCost')->where(array('ID' => $para['termid'], 'Status' => '1', 'IsDel' => '0'))->find();
        if (!$terminfo) {
            AjaxJson(0, 0, '借款期限信息异常！');
        }
        //优惠劵信息校验
        if ($para['juanid'] != '0') {
            if ($goodinfo['CashCoupon'] == '2') {
                AjaxJson(0, 0, '此借款金额暂不支持使用优惠劵！');
            }
            $coupaninfo = M(self::T_MEMCOUPANS)->field('ID,StartMoney,StartTime,Money')->where(array('ID' => $para['juanid'], 'UserID' => $mem['ID'], 'Isuser' => '1', 'IsDel' => '0', 'EndTime' => array('EGT', date('Y-m-d H:i:s'))))->find();
            if (!$coupaninfo) {
                AjaxJson(0, 0, '优惠劵信息异常！');
            }
            if ($goodinfo['SalePrice'] < $coupaninfo['StartMoney']) {
                AjaxJson(0, 0, '此借款金额不符合此优惠劵使用条件！');
            }
            if ($coupaninfo['StartTime'] > date('Y-m-d H:i:s')) {
                AjaxJson(0, 0, '此优惠劵暂不能使用！');
            }
        }

        //提交借款申请
        $hkmoney = '0';//到期应还金额
        if ($coupaninfo) {
            $hkmoney = $goodinfo['SalePrice'] - $coupaninfo['Money'] + $goodinfo['Interest'] + $terminfo['Applyfee'];
        } else {
            $hkmoney = $goodinfo['SalePrice'] + $goodinfo['Interest'] + $terminfo['Applyfee'];
        }
        $model = M();
        $model->startTrans();//事物开始进行数据库 操作
        $paraterinfos = M(self::T_LOANSPARAMETER)->find();//贷款参数
        //提交借款申请
        $OrderSn = date(ymd) . rand(1, 9) . date(His) . rand(111, 999);
        $AdoptMoney = $goodinfo['Fastmoney'] + $terminfo['Fastmoney'];//快速申请费
        $FJMoney = $goodinfo['GuanliCost'] + $terminfo['GuanliCost'];//用户管理费
        $Interest = $goodinfo['Interest'] + $terminfo['Applyfee'];//利息
        $applydata = array(
            'UserID' => $mem['ID'],
            'ApplyTime' => date('Y-m-d H:i:s'),
            'OrderSn' => $OrderSn,
            'LoanNo' => $OrderSn,
            'ApplyMoney' => $goodinfo['SalePrice'],
            'AdoptMoney' => $AdoptMoney,
            'FJMoney' => $FJMoney,
            'Interest' => $Interest,
            'ApplyDay' => $terminfo['NumDays'],
            'ProductID' => $goodinfo['ID'],
            'OpenM' => $goodinfo['SalePrice'] - $AdoptMoney - $FJMoney,
            'BackM' => $hkmoney,
            //'SqAdminID'=>,//申请专属客服
            //'LoanSum'=>,
            'RongDay' => $paraterinfos['RongDay'],
            'RongP' => $paraterinfos['RongP'],
            'OverdueDay' => $paraterinfos['OverdueDay'],
            'OverdueP' => $paraterinfos['OverdueP'],
            //'FKadminID'=>,//放款专属客服
        );
        if ($coupaninfo) {
            //使用了优惠劵
            $applydata['CouponID'] = $coupaninfo['ID'];
            $applydata['CoMoney'] = $coupaninfo['Money'];
        }
        //分配客服
        $kefudata = getkefudata($mem['ID']);
        if ($kefudata['kfid']) {
            $applydata['SqAdminID'] = $kefudata['kfid'];
        }
        if ($kefudata['fkid']) {
            $applydata['FKadminID'] = $kefudata['fkid'];
        }
        if ($kefudata['csid']) {
            $applydata['CsadminID'] = $kefudata['csid'];
        }
        $result2 = $model->table('xb_loans_applylist')->add($applydata);
//		P($result2);DIE;
        if ($result2) {
            //如果使用了优惠劵就更新优惠劵表
            if ($coupaninfo) {
                //使用了优惠劵
                $jsdata = array(
                    'Isuser' => '2',
                    'Oid' => $result2,
                    'Gid' => $goodinfo['ID'],
                    'UseTime' => date('Y-m-d H:i:s'),
                );
                $jres = $model->table('xb_mem_coupans')->where(array('ID' => $coupaninfo['ID']))->save($jsdata);
                if (!$jres) {
                    $model->rollback();
                    AjaxJson(0, 0, '抱歉，优惠劵信息更新失败！');
                }
            }
            $model->commit();
//		规则验证@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		获取有盾数据getField('Yddatas')
		$mobileinfos=M('renzen_cards')->where(array('UserID'=>$mem['ID']))->getField('Yddatas');
	    $mobileinfos=unserialize($mobileinfos);
//		$yuyinghsangba=M('renzen_mobile')->where(array('UserID'=>$mem['ID']))->getField('baogao');
//		$yuyinghsangba=json_decode($yuyinghsangba,1);
//		$tabaobg=M('renzen_taobao')->where(array('UserID'=>$mem['ID']))->getField('Receivers');
//		$tabaobg=json_decode($tabaobg,1);
		$zhimafen=M('renzen_taobao')->where(array('UserID'=>$mem['ID']))->getField('zhimafen');
		$sql = M('renzen_cards')->getLastSql();
            //新颜雷达$xinyanar
            //负面洗白$fumianxibaiar
            //有盾$mobileinfos
            //负面拉黑$fumianlaheiar
            //淘宝认证报告 $tabaobg
            //运营商yuyinghsangba
//		$guize=$this->guize($xinyanar,$fumianxibaiar,$mobileinfos,$fumianlaheiar,$tabaobg,$yuyinghsangba,$zhimafen);
        $guize=$this->xinguize($mobileinfos,$zhimafen);

            $myfile = fopen("guize.txt", "w") or die("Unable to open file!");
            fwrite($myfile,date('Y-m-d h:i:s',time()));
            fwrite($myfile,'芝麻分='.$zhimafen.'返回值='.$guize.'用户id='.$mem['ID'].'执行sql'.$sql);
            fclose($myfile);
////	修改申请借款状态
		if(!$guize){
// 			$time='1';
//			$this->AjaxJson_ios(0,1,'请等待审核！',$time);
//		    $size = ob_get_length();
//		    header("Content-Length: $size");
//		    header('Connection: close');
//		    header("HTTP/1.1 200 OK");
//		    header("Content-Type: application/json;charset=utf-8");
//		    ob_end_flush();
//		    if(ob_get_length())
//		        ob_flush();
//		    flush();
//		    if (function_exists("fastcgi_finish_request")) { // yii或yaf默认不会立即输出，加上此句即可（前提是用的fpm）
//			    fastcgi_finish_request(); // 响应完成, 立即返回到前端,关闭连接
//			}
//			ignore_user_abort(true);//在关闭连接后，继续运行php脚本
//			set_time_limit(0); //no time limit，不设置超时时间（根据实际情况使用）
//			//继续运行的代码
//			sleep(25);
			$re=M('loans_applylist')->where(array('ID'=>$result2))->save(array('LoanStatus'=>'5'));
			if($re){
				   $applyinfos=M('loans_applylist')->where(array('ID'=>$result2))->find();
				   $msgcont='尊敬的会员，您提交的申请订单：'.$applyinfos['LoanNo'].'，审核失败!';
                 send_mem_notics($applyinfos['UserID'],$msgcont);//发送站内通知消息
			}
//
		}else{
          AjaxJson(0,1,'初审已经通过  请等待人工审核！');

		}

            AjaxJson(0, 1, '订单已经提交,请等待审核！');
        } else {
            $model->rollback();
            AjaxJson(0, 0, '申请提交失败！');
        }
    }
    //规则
//$data1 雷达
//$data2 负面洗白
//$data3  有盾身份验证
//$data4  负面拉黑
//$data5  淘宝热证
//$data6 运营商认证
//通过验证返回 ture
//不通过返回 FALSE

    public function xinguize($data3, $data7)
    {
        //新颜雷达$xinyanar
        //负面洗白$fumianxibaiar
        //有盾$mobileinfos
        //负面拉黑$fumianlaheiar
        //淘宝认证报告 tabaobg
        //运营商yuyinghsangba
        //芝麻分  $芝麻分
        $data = M('ss_guize_leida')->find();  //获取规则配置

//		芝麻分
		if($data7<$data['zhimafen']){
			if($data['zhimafen_status']==2){
					 return FALSE;
				}
		}
//		有盾分值判断
        if ($data3['ud_order_no']) {
            //			高风险
            if ($data3['score_detail']['score'] > $data['youdungao']) {
                if ($data['youdungao_status'] == 2) {
                    return FALSE;
                }
            }
            //		中风险
            if ($data3['score_detail']['score'] > 55) {
                if ($data['youdun_zhong_status'] == 2) {
                    return FALSE;
                }
            }

            //			低风险
            if ($data3['score_detail']['score'] < 55) {
                if ($data['youdun_di_status'] == 2) {
                    return FALSE;
                }
            }
            //			总申请借款平台数
            if ($data3['loan_detail']['loan_platform_count'] > $data['shenqing_num']) {
                if ($data['shenqing_num_status'] == 2) {
                    return FALSE;
                }
            }
            //			总借款平台数
            if ($data3['loan_detail']['actual_loan_platform_count'] < $data['jiekuan_num']) {
                if ($data['jiekuan_num_status'] == 2) {
                    return FALSE;
                }
            }
            //			总还款平台数
            if ($data3['loan_detail']['repayment_platform_count'] > $data['huankuan_pingtai_num']) {
                if ($data['huankuan_pingtai_num_status'] == 2) {
                    return FALSE;
                }
            }
            //          总还款比数
            if ($data3['loan_detail']['huankuan_cishu_num'] < $data['huankuan_cishu_num']) {
                if ($data['huankuan_cishu_num_status'] == 2) {
                    return FALSE;
                }
            }

            //			命中作弊软件
            if ($data3['device_detail']['cheats_device'] > 0) {
                if ($data['zuobi_status'] == 2) {
                    return FALSE;
                }
            }
            //			命中安装极多借款app
            if ($data3['device_detail']['app_instalment_count'] > 3) {
                if ($data['anzhuang_status'] == 2) {
                    return FALSE;
                }
            }

            //			命中法院失信黑名单>
            if ($data3['graph_detail']['link_user_detail']['court_dishonest_count']) {
                if ($data['fayuanshixin_status'] == 2) {
                    return FALSE;
                }
            }
            //命中网贷失信黑名单>
            if ($data3['graph_detail']['link_user_detail']['online_dishonest_count']) {
                if ($data['wangdaishixin_status'] == 2) {
                    return FALSE;
                }
            }
        }
        return TRUE;
    }

    public function httpPost_yanshi($post_data, $url)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_TIMEOUT, 500);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
//  curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 3);//设置一秒超时
//  curl_setopt($curl, CURLOPT_MAXREDIRS, 1);//查找次数，防止查找太深
        // post数据
        curl_setopt($curl, CURLOPT_POST, 1);
        // post的变量
        curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
        $res = curl_exec($curl);
        curl_close($curl);
        return $res;
    }

// ios提交借款订单
    public function downorderios()
    {

        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        $ressssss = M('loans_applylist')->where(['UserID' => $mem['ID'], 'LoanStatus' => '6'])->find();
        if ($ressssss) {
            AjaxJson(0, 0, '有正在执行的订单 ，请勿重复提交');//判断是否有正在等待银行打款的订单
        }
        $ressssss = M('loans_applylist')->where(['UserID' => $mem['ID'], 'LoanStatus' => '7'])->find();
        if ($ressssss) {
            AjaxJson(0, 0, '有正在执行的订单 ，请及时联系客服');//判断是否有正在等待银行打款的订单
        }
//		$datainfo['id_no']=$mem['IDCard'];//被查询人身份证号
//		$datainfo['id_name']=$mem['TrueName'];//姓名
//		$datainfo['phone_no']=$mem['Mobile'];//手机号
//		$xinyanar=$this->xinyan($datainfo);//调用雷达  数据入库
//		$xinyan=json_encode($xinyanar,1);
//		$xinyanbagao['UserID']=$mem['ID'];
//		$xinyanbagao['status']='1';
//		$xinyanbagao['data']=$xinyan;
//		$xinyanbagao['create_time']=date('Y-m-d h:i:s',time());
//		$dateleida=M('ss_bgdata')->where(['UserID'=>$mem['ID'],'status'=>1])->find();
//		if($dateleida){
//			$xinyanbagao['update_time']=date('Y-m-d h:i:s',time());
//			$aa=M('ss_bgdata')->where(['ID'=>$dateleida['ID']])->save($xinyanbagao);
//			if(!$aa){
//				 AjaxJson(0,0,'新颜雷达资信数据更新失败,申请提交失败！');//ss
//			}
//		}else{
//		   $leidaid=M('ss_bgdata')->add($xinyanbagao);
//		   if(!$leidaid){
//				 AjaxJson(0,0,'新颜雷达资信数据保存失败,申请提交失败！');//ss
//			}
//	   }
//		负面洗白数据入库
//		$fumianxibaiar=$this->fumianxibai($datainfo);
//	    $fumianxibai=json_encode($fumianxibaiar,1);
//		p($fumianxibai);
//		$fumianxibaibaogao['UserID']=$mem['ID'];
//		$fumianxibaibaogao['status']='2';
//		$fumianxibaibaogao['data']=$fumianxibai;
//		$fumianxibaibaogao['create_time']=date('Y-m-d h:i:s',time());
//		$datexibai=M('ss_bgdata')->where(['UserID'=>$mem['ID'],'status'=>2])->find();
//		if($datexibai){
//			$fumianxibaibaogao['update_time']=date('Y-m-d h:i:s',time());
//			$bb=M('ss_bgdata')->where(['ID'=>$datexibai['ID']])->save($fumianxibaibaogao);
//			if(!$bb){
//
//				 AjaxJson(0,0,'新颜负面洗白资信数据更新失败,申请提交失败！');//ss
//			}
//		}else{
//		  $xibaiid=M('ss_bgdata')->add($fumianxibaibaogao);
//		  if(!$xibaiid){
//				 AjaxJson(0,0,'新颜负面洗白资信数据保存失败,申请提交失败！');//ss
//			}
//		}
//		负面拉黑数据入库
//		$fumianlaheiar=$this->fumianlahei($datainfo);
//	    $fumianlahei=json_encode($fumianlaheiar,1);
//		p($fumianlahei);
//		$fumianlaheibaogao['UserID']=$mem['ID'];
//		$fumianlaheibaogao['status']='3';
//		$fumianlaheibaogao['data']=$fumianlahei;
//		$fumianlaheibaogao['create_time']=date('Y-m-d h:i:s',time());
//		$datelahei=M('ss_bgdata')->where(['UserID'=>$mem['ID'],'status'=>3])->find();
//		p($datelahei);
//		if($datelahei){
//			$fumianlaheibaogao['update_time']=date('Y-m-d h:i:s',time());
//			$cc=M('ss_bgdata')->where(['ID'=>$datelahei['ID']])->save($fumianlaheibaogao);
//			if(!$cc){
//				 AjaxJson(0,0,'新颜负面拉黑资信数据更新失败,申请提交失败！');//ss
//			}
//		}else{
//		  $xibaiid=M('ss_bgdata')->add($fumianlaheibaogao);
//		  if(!$xibaiid){
//				 AjaxJson(0,0,'新颜负面拉黑资信数据保存失败,申请提交失败！');//ss
//			}
//		}
        //校验
        if (!$para['gid']) {
            AjaxJson(0, 0, '请选择借款金额！');
        }
        if (!$para['termid']) {
            AjaxJson(0, 0, '请选择借款期限！');
        }
        //校验 是否有借款的条件
        $rtdata = checkmembuy($mem['ID']);
        if ($rtdata['result'] == '0') {
            AjaxJson(0, 0, $rtdata['message']);
        }
        //校验必须认证
        $checkflags = checkmust_renz($mem['ID']);
        if (!$checkflags) {
            AjaxJson(0, 0, '必须认证未认证完，请先去认证！');
        }
        //校验会员年龄有没有达到借款条件
        $membirthday = M('renzen_cards')->where(array('UserID' => $mem['ID'], 'Status' => '1', 'IsDel' => '0'))->getField('Birthday');
        if ($membirthday) {
            $membirthday = strtotime($membirthday);
            $memage = getage($membirthday);
            $MaxAges = get_basic_info('MaxAges');
            $MinAges = get_basic_info('MinAges');
            if ($memage < $MinAges || $memage > $MaxAges) {
                AjaxJson(0, 0, '抱歉，您的年龄不符合条件！');
            }
        }
        //获取会员的借款额度
        $LimitBalcance = M(self::T_MEMINFO)->where(array('ID' => $mem['ID']))->getField('LimitBalcance');
//		P($LimitBalcance);
        $goodinfo = M(self::T_GOODS)->field('ID,SalePrice,Interest,Fastmoney,GuanliCost,CashCoupon')->where(array('ID' => $para['gid'], 'SalePrice' => array('ELT', $LimitBalcance), 'IsShelves' => '1', 'IsDel' => '0'))->find();
        if (!$goodinfo) {
            AjaxJson(0, 0, '借款金额信息异常！');
        }
        $terminfo = M('loans_term')->field('ID,NumDays,Applyfee,Fastmoney,GuanliCost')->where(array('ID' => $para['termid'], 'Status' => '1', 'IsDel' => '0'))->find();
        if (!$terminfo) {
            AjaxJson(0, 0, '借款期限信息异常！');
        }
        //优惠劵信息校验
        if ($para['juanid'] != '0') {
            if ($goodinfo['CashCoupon'] == '2') {
                AjaxJson(0, 0, '此借款金额暂不支持使用优惠劵！');
            }
            $coupaninfo = M(self::T_MEMCOUPANS)->field('ID,StartMoney,StartTime,Money')->where(array('ID' => $para['juanid'], 'UserID' => $mem['ID'], 'Isuser' => '1', 'IsDel' => '0', 'EndTime' => array('EGT', date('Y-m-d H:i:s'))))->find();
            if (!$coupaninfo) {
                AjaxJson(0, 0, '优惠劵信息异常！');
            }
            if ($goodinfo['SalePrice'] < $coupaninfo['StartMoney']) {
                AjaxJson(0, 0, '此借款金额不符合此优惠劵使用条件！');
            }
            if ($coupaninfo['StartTime'] > date('Y-m-d H:i:s')) {
                AjaxJson(0, 0, '此优惠劵暂不能使用！');
            }
        }

        //提交借款申请
        $hkmoney = '0';//到期应还金额
        if ($coupaninfo) {
            $hkmoney = $goodinfo['SalePrice'] - $coupaninfo['Money'] + $goodinfo['Interest'] + $terminfo['Applyfee'];
        } else {
            $hkmoney = $goodinfo['SalePrice'] + $goodinfo['Interest'] + $terminfo['Applyfee'];
        }
        $model = M();
        $model->startTrans();//事物开始进行数据库 操作
        $paraterinfos = M(self::T_LOANSPARAMETER)->find();//贷款参数
        //提交借款申请
        $OrderSn = date(ymd) . rand(1, 9) . date(His) . rand(111, 999);
        $AdoptMoney = $goodinfo['Fastmoney'] + $terminfo['Fastmoney'];//快速申请费
        $FJMoney = $goodinfo['GuanliCost'] + $terminfo['GuanliCost'];//用户管理费
        $Interest = $goodinfo['Interest'] + $terminfo['Applyfee'];//利息
        $applydata = array(
            'UserID' => $mem['ID'],
            'ApplyTime' => date('Y-m-d H:i:s'),
            'OrderSn' => $OrderSn,
            'LoanNo' => $OrderSn,
            'ApplyMoney' => $goodinfo['SalePrice'],
            'AdoptMoney' => $AdoptMoney,
            'FJMoney' => $FJMoney,
            'Interest' => $Interest,
            'ApplyDay' => $terminfo['NumDays'],
            'ProductID' => $goodinfo['ID'],
            'OpenM' => $goodinfo['SalePrice'] - $AdoptMoney - $FJMoney,
            'BackM' => $hkmoney,
            //'SqAdminID'=>,//申请专属客服
            //'LoanSum'=>,
            'RongDay' => $paraterinfos['RongDay'],
            'RongP' => $paraterinfos['RongP'],
            'OverdueDay' => $paraterinfos['OverdueDay'],
            'OverdueP' => $paraterinfos['OverdueP'],
            //'FKadminID'=>,//放款专属客服
        );
        if ($coupaninfo) {
            //使用了优惠劵
            $applydata['CouponID'] = $coupaninfo['ID'];
            $applydata['CoMoney'] = $coupaninfo['Money'];
        }
        //分配客服
        $kefudata = getkefudata($mem['ID']);
        if ($kefudata['kfid']) {
            $applydata['SqAdminID'] = $kefudata['kfid'];
        }
        if ($kefudata['fkid']) {
            $applydata['FKadminID'] = $kefudata['fkid'];
        }
        if ($kefudata['csid']) {
            $applydata['CsadminID'] = $kefudata['csid'];
        }
        $result2 = $model->table('xb_loans_applylist')->add($applydata);
//		P($result2);DIE;
        if ($result2) {
            //如果使用了优惠劵就更新优惠劵表
            if ($coupaninfo) {
                //使用了优惠劵
                $jsdata = array(
                    'Isuser' => '2',
                    'Oid' => $result2,
                    'Gid' => $goodinfo['ID'],
                    'UseTime' => date('Y-m-d H:i:s'),
                );
                $jres = $model->table('xb_mem_coupans')->where(array('ID' => $coupaninfo['ID']))->save($jsdata);
                if (!$jres) {
                    $model->rollback();
                    AjaxJson(0, 0, '抱歉，优惠劵信息更新失败！');
                }
            }
            $model->commit();
//		规则验证@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		获取有盾数据getField('Yddatas')
//		$mobileinfos=M('renzen_cards')->where(array('User_ID'=>$mem['ID']))->getField('Yddatas');
//	    $mobileinfos=unserialize($mobileinfos);
//		$yuyinghsangba=M('renzen_mobile')->where(array('User_ID'=>$mem['ID']))->getField('baogao');
//		$yuyinghsangba=json_decode($yuyinghsangba,1);
//		$tabaobg=M('renzen_taobao')->where(array('User_ID'=>$mem['ID']))->getField('Receivers');
//		$tabaobg=json_decode($tabaobg,1);
//		$zhimafen=M('renzen_taobao')->where(array('User_ID'=>$mem['ID']))->getField('zhimafen');
            //新颜雷达$xinyanar
            //负面洗白$fumianxibaiar
            //有盾$mobileinfos
            //负面拉黑$fumianlaheiar
            //淘宝认证报告 $tabaobg
            //运营商yuyinghsangba
//		$guize=$this->guize($xinyanar,$fumianxibaiar,$mobileinfos,$fumianlaheiar,$tabaobg,$yuyinghsangba,$zhimafen);


////		修改申请借款状态
//		if(!$guize){
// 			$time='1';//返回一个时间让前端做延时处理
//			M('loans_applylist')->where(['id'=>$result2])->save(['LoanStatus'=>'5']);
//			$this->AjaxJson(0,1,'请等待审核！',$time);
//		}else{
//			$time='1';//返回一个时间让前端做延时处理
//			AjaxJson(0,1,'初审已经通过 请等待人工审核！',$time);
//		}
            $time = '1';//返回一个时间让前端做延时处理
            AjaxJson(0, 1, '订单已经提交,请等待审核！', $time);


        } else {
            $model->rollback();
            AjaxJson(0, 0, '申请提交失败！');
        }
    }

    public function AjaxJson_ios($mark = 0, $code = 0, $msg = 'success', $data = array(), $isaes = 0, $key = '', $iv = '')
    {
        $Array = array();
        if (is_array($code)) {
            $Array = $code;
        } else {
            if (!$msg) {
                $msg = 'success';
            }
            if ($isaes == 1) {
                //if(!$key || !$iv){
                $key = get_login_info('KEY');
                $iv = get_login_info('IV');
                //}
                if ($mark) {
                    $json = json_encode($data);
                } else {
                    $json = json_encode($data, JSON_FORCE_OBJECT);
                }
                $data = encrypt_pkcs7($json, $key, $iv);
            }
            if ($isaes == 1 && empty($data)) {
                $data = 'abc';
            }
            $Array = array(
                'result' => $code,
                'data' => $data,
                'message' => $msg,
                'isaes' => $isaes,
                'mark' => $mark,
                'time' => $data,
            );
        }
        if ($mark == 0) {
            echo(json_encode($Array, JSON_FORCE_OBJECT));
        } else {
            echo(json_encode($Array));
        }
    }

//规则
//$data1 雷达
//$data2 负面洗白
//$data3  有盾身份验证
//$data4  负面拉黑
//$data5  淘宝热证
//$data6 运营商认证
//通过验证返回 ture
//不通过返回 FALSE

    public function guize($data1, $data2, $data3, $data4, $data5, $data6, $data7)
    {
        //新颜雷达$xinyanar
        //负面洗白$fumianxibaiar
        //有盾$mobileinfos
        //负面拉黑$fumianlaheiar
        //淘宝认证报告 tabaobg
        //运营商yuyinghsangba
        //芝麻分  $芝麻分
//		P($data1);
//		P($data2);
//		P($data3);
//		P($data4);
//		P($data5);
//		P($data6);
//      P($data7);

        $data = M('ss_guize_leida')->find();  //获取规则配置
// 		雷达
        if ($data1['success']) {
//			申请分判断
            if ($data1['data']['result_detail']['apply_report_detail']['apply_score'] < $data['xy_100001']) {
                if ($data['xy_100001_status'] == 2) {
                    return FALSE;
                }
            }
//				申请准入置信度
            if ($data1['data']['result_detail']['apply_report_detail']['apply_credibility'] < $data['daikuanyuqi_num']) {
                if ($data['daikuanyuqi_num_status'] == 2) {
                    return FALSE;
                }
            }
//		 放款订单数      比如我自己 没有这个数据 就说明信用良好 不用做此类判断
            if ($data1['data']['result_detail']['behavior_report_detail']) {


                if ($data1['data']['result_detail']['behavior_report_detail']['loans_count'] < $data['xy_100007']) {
                    if ($data['xy_100007_status'] == 2) {
                        return FALSE;
                    }
                }
                //				结清订单数
                if ($data1['data']['result_detail']['behavior_report_detail']['loans_settle_count'] < $data['xy_100008']) {
                    if ($data['xy_100008_status'] == 2) {
                        return FALSE;
                    }
                }
                //				贷款逾期订单数>
                if ($data1['data']['result_detail']['behavior_report_detail']['loans_overdue_count'] < $data['xy_100009']) {
                    if ($data['xy_100009_status'] == 2) {
                        return FALSE;
                    }
                }
                //              贷款机构数>
                if ($data1['data']['result_detail']['behavior_report_detail']['loans_org_count'] < $data['xy_100010']) {
                    if ($data['xy_100010_status'] == 2) {
                        return FALSE;
                    }
                }
            }
        }
//      负面洗白
//		        if($data3['success']==1){
        if ($data3['data']['result_detail']) {//此项如果为空 证明信用良好 比如我的数据
//						如果有数据在进行判断
        }
//			    }
//		魔蝎运行商


//		芝麻分
//		if($data7<$data['zhimafen']){
//			if($data['zhimafen_status']==2){
//					 return FALSE;
//				}
//		}

///  魔蝎淘宝
//		$hbsxed=$data6['alipaywealth']['huabei_totalcreditamount']/100;//花呗授信额度
//		if($hbsxed<$data['huebeiedu']){
//			if($data['huebeiedu_status']==2){
//					 return FALSE;
//				}
//		}


//		$hbkyed=$data6['alipaywealth']['huabei_creditamount']/100;//花呗可用额度
//
//		if($hbkyed<$data['jiebeiedu']){
//			if($data['jiebeiedu_status']==2){
//					 return FALSE;
//				}
//		}


//		有盾分值判断
        if ($data3['ud_order_no']) {
            //			高风险
            if ($data3['score_detail']['score'] > $data['youdungao']) {
                if ($data['youdungao_status'] == 2) {
                    return FALSE;
                }
            }
            ////		中风险
            if ($data3['score_detail']['score'] > 55) {
                if ($data['youdun_zhong_status'] == 2) {
                    return FALSE;
                }
            }

            ////			低风险
            if ($data3['score_detail']['score'] < 55) {
                if ($data['youdun_di_status'] == 2) {
                    return FALSE;
                }
            }
            //			总申请借款平台数
            if ($data3['loan_detail']['loan_platform_count'] > $data['shenqing_num']) {
                if ($data['shenqing_num_status'] == 2) {
                    return FALSE;
                }
            }
            ////			总借款平台数
            if ($data3['loan_detail']['actual_loan_platform_count'] < $data['jiekuan_num']) {
                if ($data['jiekuan_num_status'] == 2) {
                    return FALSE;
                }
            }
            ////			总还款平台数
            if ($data3['loan_detail']['repayment_platform_count'] > $data['huankuan_pingtai_num']) {
                if ($data['huankuan_pingtai_num_status'] == 2) {
                    return FALSE;
                }
            }
            ////          总还款比数
            if ($data3['loan_detail']['huankuan_cishu_num'] < $data['huankuan_cishu_num']) {
                if ($data['huankuan_cishu_num_status'] == 2) {
                    return FALSE;
                }
            }

            ////			命中作弊软件
            if ($data3['device_detail']['cheats_device'] > 0) {
                if ($data['zuobi_status'] == 2) {
                    return FALSE;
                }
            }
            ////			命中安装极多借款app
            if ($data3['device_detail']['app_instalment_count'] > 3) {
                if ($data['anzhuang_status'] == 2) {
                    return FALSE;
                }
            }

            ////			命中法院失信黑名单>
            if ($data3['graph_detail']['link_user_detail']['court_dishonest_count']) {
                if ($data['fayuanshixin_status'] == 2) {
                    return FALSE;
                }
            }
            ////命中网贷失信黑名单>
            if ($data3['graph_detail']['link_user_detail']['online_dishonest_count']) {
                if ($data['wangdaishixin_status'] == 2) {
                    return FALSE;
                }
            }
        }
//		负面拉黑建议 如果为零 建议拉黑
        if ($data4['data']['code'] == 0) {
            return FALSE;
        }
        return TRUE;
    }
//Array
//(雷达
//  [success] => 1
//  [data] => Array
//      (
//          [fee] => Y
//          [code] => 0
//          [desc] => 查询成功
//          [trans_id] => b3f29c61-9d3e-b36d-208b-1f78f55ca2e6
//          [trade_no] => 20180930102822663000002625834514
//          [id_no] => 412824199207222617
//          [id_name] => 宋林博
//          [versions] => 1.3.0
//          [result_detail] => Array
//              (
//                  [current_report_detail] =>
//                  [behavior_report_detail] =>
//                  [apply_report_detail] => Array
//                      (
//                          [latest_query_time] => 2018-09-29
//                          [query_sum_count] => 7
//                          [apply_credibility] => 74
//                          [query_org_count] => 4
//                          [latest_six_month] => 7
//                          [query_cash_count] => 0
//                          [apply_score] => 527
//                          [latest_three_month] => 7
//                          [query_finance_count] => 2
//                          [latest_one_month] => 4
//                      )
//
//              )
//
//      )
//
//  [errorCode] =>
//  [errorMsg] =>
//)
//Array
//(负面洗白
//  [success] => 1
//  [data] => Array
//      (
//          [fee] => N
//          [code] => 3
//          [desc] => 空值未知
//          [trans_id] => e6e16fc8-278d-597a-897d-f8e27476e239
//          [trade_no] => 20180930102823018000002625841089
//          [id_no] => 412824199207222617
//          [id_name] => 宋林博
//          [versions] => 1.3.0
//          [result_detail] =>
//      )
//
//  [errorCode] =>
//  [errorMsg] =>
//)

//<pre>Array
//(有盾身份验证
//  [user_features] => Array
//      (
//          [0] => Array
//              (
//                  [user_feature_type] => 10
//                  [last_modified_date] => 2018-09-30
//              )
//
//      )
//
//  [last_modified_time] => 2018-09-30 09:49:25
//  [id_detail] => Array
//      (
//          [birthday] => 1992.07.22
//          [address] => 河南省西平县专探乡朱湖村委十二组
//          [names] => 宋林博
//          [gender] => 男
//          [id_number_mask] => 4128************17
//          [nation] => 汉
//          [name_credible] => 宋林博
//      )
//
//  [graph_detail] => Array
//      (
//          [mobile_count] => 0
//          [link_user_count] => 0
//          [other_link_device_count] => 0
//          [link_user_detail] => Array
//              (
//                  [partner_mark_count] => 0
//                  [court_dishonest_count] => 0
//                  [online_dishonest_count] => 0
//                  [living_attack_count] => 0
//              )
//
//          [user_have_bankcard_count] => 0
//          [other_link_device_detail] => Array
//              (
//                  [other_frand_device_count] => 0
//                  [other_living_attack_device_count] => 0
//              )
//
//          [partner_user_count] => 0
//          [bankcard_count] => 0
//          [link_device_detail] => Array
//              (
//                  [frand_device_count] => 0
//                  [living_attack_device_count] => 0
//              )
//
//          [link_device_count] => 2
//      )
//
//  [loan_detail] => Array
//      (
//          [actual_loan_platform_count] => 1
//          [actual_loan_platform_count_3m] => 0
//          [actual_loan_platform_count_1m] => 0
//          [actual_loan_platform_count_6m] => 0
//          [loan_platform_count] => 1
//          [repayment_times_count] => 1
//          [repayment_platform_count_3m] => 0
//          [loan_industry] => Array
//              (
//                  [0] => Array
//                      (
//                          [actual_loan_platform_count] => 0
//                          [name] => 小额现金贷
//                          [loan_platform_count] => 0
//                          [repayment_times_count] => 0
//                          [repayment_platform_count] => 0
//                      )
//
//                  [1] => Array
//                      (
//                          [actual_loan_platform_count] => 1
//                          [name] => 分期行业
//                          [loan_platform_count] => 1
//                          [repayment_times_count] => 1
//                          [repayment_platform_count] => 1
//                      )
//
//                  [2] => Array
//                      (
//                          [name] => 大学生分期
//                          [loan_platform_count] => 0
//                      )
//
//                  [3] => Array
//                      (
//                          [name] => 电商分期
//                          [loan_platform_count] => 0
//                      )
//
//                  [4] => Array
//                      (
//                          [name] => 旅游分期
//                          [loan_platform_count] => 0
//                      )
//
//                  [5] => Array
//                      (
//                          [name] => 教育分期
//                          [loan_platform_count] => 0
//                      )
//
//                  [6] => Array
//                      (
//                          [name] => 汽车分期
//                          [loan_platform_count] => 0
//                      )
//
//                  [7] => Array
//                      (
//                          [name] => 租房分期
//                          [loan_platform_count] => 0
//                      )
//
//                  [8] => Array
//                      (
//                          [name] => 农业消金
//                          [loan_platform_count] => 0
//                      )
//
//                  [9] => Array
//                      (
//                          [name] => 医美分期
//                          [loan_platform_count] => 0
//                      )
//
//              )
//
//          [loan_platform_count_3m] => 0
//          [loan_platform_count_6m] => 0
//          [repayment_platform_count_1m] => 0
//          [repayment_platform_count] => 1
//          [repayment_platform_count_6m] => 0
//          [loan_platform_count_1m] => 0
//      )
//
//  [score_detail] => Array
//      (
//          [score] => 30
//          [risk_evaluation] => 中低风险
//      )
//
//  [devices_list] => Array
//      (
//          [0] => Array
//              (
//                  [device_name] => Meizu 15
//                  [device_id] => 97_b8707f41-1f95-469c-bc43-0cd78eb64134
//                  [device_link_id_count] => 1
//                  [device_last_use_date] => 2018-09-30
//                  [device_detail] => Array
//                      (
//                          [app_instalment_count] => 2
//                          [is_rooted] => 0
//                          [cheats_device] => 0
//                          [is_using_proxy_port] => 0
//                          [network_type] => mobile network
//                      )
//
//              )
//
//          [1] => Array
//              (
//                  [device_name] => Xiaomi MIX 2S
//                  [device_id] => 97_26257fa2-3151-44f8-9e92-56c998badd61
//                  [device_link_id_count] => 3
//                  [device_last_use_date] => 2018-09-30
//                  [device_detail] => Array
//                      (
//                          [app_instalment_count] => 0
//                          [is_rooted] => 0
//                          [fraud_device] => 1
//                          [cheats_device] => 0
//                          [is_using_proxy_port] => 0
//                          [network_type] => WiFi
//                      )
//
//              )
//
//      )
//
//  [ud_order_no] => 372350708513505288
//)
//</pre>

    /**
     * @功能说明: 订单列表
     * @传输格式: 私有token,有提交，密文返回
     * @提交网址: /center/Order/orderlist
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"page":"0","rows":"20","status":"6"}}
     *  status 订单状态 0申请中 1放款中 2已放款 3已完成 4已取消 5已拒绝 6全部
     * @返回信息: {'result'=>1,'message'=>'恭喜您，获取成功！','data'}
     */
    public function orderlist()
    {
        $para = get_json_data();
        $mem = getUserInfo(get_login_info('ID'));

        if (!in_array($para['status'], array('0', '1', '2', '3', '4', '5', '6'))) {
            AjaxJson(0, 0, '订单状态异常！');
        }
        $page = $para['page'] ? $para['page'] : 0;
        $rows = $para['rows'] ? $para['rows'] : 10;
        $statusArr = $this->statusArr;
        $where = array();
        $where['UserID'] = array('eq', $mem['ID']);
        $where['IsDel'] = array('eq', '0');
        if ($para['status'] != '6') {
            $where['LoanStatus'] = array('eq', $para['status']);
        }
        $orderlist = M('loans_applylist')->field('ID,ApplyTime,OrderSn,ApplyMoney,ApplyDay,LoanType,LoanStatus,OpenTime,YyFkTime,IsYQ')
            ->where($where)->order('ID desc')->limit($page * $rows, $rows)->select();
        if ($orderlist) {
            foreach ($orderlist as $k => &$v) {
                if ($v['LoanType'] == '0') {
                    $v['LoanType'] = '普通借款';
                } elseif ($v['LoanType'] == '1') {
                    $v['LoanType'] = '续借';
                } elseif ($v['LoanType'] == '2') {
                    $v['LoanType'] = '分期';
                }
                if (!$v['OpenTime']) {
                    $v['OpenTime'] = '';
                }
                if (!$v['YyFkTime']) {
                    $v['YyFkTime'] = '';
                }
                //查看是否逾期
                if ($v['LoanStatus'] == '2') {
                    //过了当天夜里24点才算逾期
                    $overtimes = '';
                    $overtimes = date('Y-m-d', strtotime($v['YyFkTime'])) . ' 23:59:59';
                    if ($overtimes < date('Y-m-d H:i:s')) {
                        // $yuqidata='';
                        // $yuqidata=getoverinfos($v['ID']);
                        // $retdata['TotalMoney']=$yuqidata['realtotal'];
                        // $retdata['famoney']=$yuqidata['famoney'];
                        $v['IsYQ'] = '1';
                    } else {
                        //未逾期
                        $v['IsYQ'] = '0';
                        //$retdata['TotalMoney']=$v['BackM'];
                    }
                }
                $v['statusname'] = $statusArr[$v['LoanStatus']];
            }
        }
        AjaxJson(1, 1, '恭喜您，数据查询成功！', $orderlist, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 取消订单
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/cancelorder
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222"}}
     *   oid 订单的主键id   ordersn订单编号
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function cancelorder()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $orderinfo = M(self::T_LOANSAPPLYLIST)->field('ID,Status')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'IsDel' => '0'))->find();
        if (!$orderinfo) {
            AjaxJson(0, 0, '订单信息不存在！');
        }
        if ($orderinfo['Status'] != '0') {
            AjaxJson(0, 0, '此订单不能取消操作！');
        }
        $result = M(self::T_LOANSAPPLYLIST)->where(array('ID' => $para['oid']))->save(array('LoanStatus' => '4'));
        if ($result) {
            AjaxJson(0, 1, '取消成功！');
        } else {
            AjaxJson(0, 0, '取消失败！');
        }
    }

    /**
     * @功能说明: 借款合同
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/hetong
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222"}}
     *   oid 订单的主键id   ordersn订单编号
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function hetong()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $orderinfo = M(self::T_LOANSAPPLYLIST)->field('ID,OrderSn,ApplyTime,ApplyMoney,ApplyDay,OpenTime,Interest,FJMoney,AdoptMoney,YyFkTime,BackM')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'LoanStatus' => array('in', array('2', '3')), 'IsDel' => '0'))->find();
        if (!$orderinfo) {
            AjaxJson(0, 0, '订单信息不存在！');
        }
        $meminfo = M(self::T_MEMINFO)->field('Mobile,TrueName,IDCard')->find($mem['ID']);
        $hetonginfo = M(self::T_CONTENTMANAGEMENT)->field('Contents')->where(array('CategoriesID' => '18'))->find();
        $hetonginfo['Contents'] = htmlspecialchars_decode($hetonginfo['Contents']);
        //替换操作
        $hetonginfo['Contents'] = str_replace('{$ContractNO}', $orderinfo['OrderSn'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$AddTime}', $orderinfo['OpenTime'], $hetonginfo['Contents']);

        $hetonginfo['Contents'] = str_replace('{$Lender}', get_basic_info('CompanyName'), $hetonginfo['Contents']);

        $hetonginfo['Contents'] = str_replace('{$Borrower}', $meminfo['TrueName'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$BIdenty}', $meminfo['IDCard'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$BMobile}', $meminfo['Mobile'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$loanTime}', date('Y-m-d', strtotime($orderinfo['ApplyTime'])), $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$Principal}', $orderinfo['ApplyMoney'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$term}', $orderinfo['ApplyDay'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$Interest}', $orderinfo['Interest'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$Userfee}', $orderinfo['FJMoney'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$Applyfee}', $orderinfo['AdoptMoney'], $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$repayTime}', date('Y-m-d', strtotime($orderinfo['YyFkTime'])), $hetonginfo['Contents']);
        $hetonginfo['Contents'] = str_replace('{$repayMoney}', $orderinfo['BackM'], $hetonginfo['Contents']);
        AjaxJson(0, 1, '恭喜您，数据查询成功！', $hetonginfo, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 获取订单简单信息(我要还款页面)
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/hhdetails
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222"}}
     *   oid 订单的主键id   ordersn订单编号
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function hhdetails()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $orderinfo = M(self::T_LOANSAPPLYLIST)->field('ID,LoanStatus,ApplyTime,YyFkTime,OrderSn,ApplyMoney,AdoptMoney,FJMoney,Interest,BackM,CoMoney')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'IsDel' => '0'))->find();
        if (!$orderinfo) {
            AjaxJson(0, 0, '订单信息不存在！');
        }
        if ($orderinfo['LoanStatus'] != '2') {
            AjaxJson(0, 0, '此订单不能进行此操作了！');
        }
        $statusArr = $this->statusArr;

        $retdata = array();//返回的详情信息
        $retdata['isjump'] = '1';//能跳
        $retdata['errmsg'] = '';
        $retdata['Status'] = $orderinfo['LoanStatus'];
        $retdata['Statusname'] = $statusArr[$orderinfo['LoanStatus']];
        $retdata['ApplyTime'] = $orderinfo['ApplyTime'];
        $retdata['YyFkTime'] = $orderinfo['YyFkTime'];
        $retdata['OrderSn'] = $orderinfo['OrderSn'];
        $retdata['ApplyMoney'] = $orderinfo['ApplyMoney'];
        $retdata['AdoptMoney'] = $orderinfo['AdoptMoney'];
        $retdata['FJMoney'] = $orderinfo['FJMoney'];
        $retdata['Interest'] = $orderinfo['Interest'];
        $retdata['CoMoney'] = '';
        if ($orderinfo['CoMoney']) {
            $retdata['CoMoney'] = $orderinfo['CoMoney'];
        }
        $retdata['famoney'] = '';

        //查看是否逾期
        //过了当天夜里24点才算逾期
        $overtimes = date('Y-m-d', strtotime($orderinfo['YyFkTime'])) . ' 23:59:59';
        if ($overtimes < date('Y-m-d H:i:s')) {
            $yuqidata = '';
            $yuqidata = getoverinfos($orderinfo['ID']);
            $retdata['TotalMoney'] = $yuqidata['realtotal'];
            $retdata['famoney'] = $yuqidata['famoney'];
            $retdata['IsYQ'] = '1';

            //算出距离发货日
            $lastday = (strtotime($overtimes) - time()) / 86400;
            $lastday = abs($lastday);
            $lastday = ceil($lastday);
            $retdata['lastday'] = -$lastday;
            //算出总天数
            $totaldays = '0';
            $totaldays = (strtotime($overtimes) - strtotime($orderinfo['ApplyTime'])) / 86400;
            $totaldays = ceil($totaldays);
            $retdata['totaldays'] = $totaldays;
        } else {
            //未逾期
            $retdata['IsYQ'] = '0';
            $retdata['TotalMoney'] = $orderinfo['BackM'];

            //算出距离发货日
            $lastday = (strtotime($orderinfo['YyFkTime']) - time()) / 86400;
            $lastday = ceil($lastday);
            $retdata['lastday'] = $lastday;
            //算出总天数
            $totaldays = '0';
            $totaldays = (strtotime($orderinfo['YyFkTime']) - strtotime($orderinfo['ApplyTime'])) / 86400;
            $totaldays = ceil($totaldays);
            $retdata['totaldays'] = $totaldays;
        }
        //校验是否提交借款申请，或是提交了续借申请了
        //如果还款申请已经提交，并且还处于待审核状态，则不予提交
        $checkresult = M('loans_hklist')->where(array('ApplyID' => $orderinfo['ID'], 'PayStatus' => '0', 'Status' => '0', 'PayType' => array('neq', '3')))->count('ID');
        if ($checkresult) {
            $retdata['isjump'] = '0';//不能跳
            $retdata['errmsg'] = '还款申请审核中!';
        }
        //如果续借还在审核 不予提交
        $checkxj = M('loans_xjapplylist')->where(array('ApplyID' => $orderinfo['ID'], 'PayStatus' => '0', 'Status' => '0', 'PayType' => array('neq', '3')))->count('ID');
        if ($checkxj) {
            $retdata['isjump'] = '0';//不能跳
            $retdata['errmsg'] = '续借申请审核中!';
        }
        AjaxJson(0, 1, '恭喜您，数据查询成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 订单详情页
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/orderdetails
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222"}}
     *   oid 订单的主键id   ordersn订单编号
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function orderdetails()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $orderinfo = M(self::T_LOANSAPPLYLIST)->field('ID,LoanStatus,ApplyTime,YyFkTime,OrderSn,ApplyMoney,AdoptMoney,FJMoney,Interest,ApplyDay,LoanType,OpenTime,CoMoney')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'IsDel' => '0'))->find();
        if (!$orderinfo) {
            AjaxJson(0, 0, '订单信息不存在！');
        }
        $statusArr = $this->statusArr;

        $retdata = array();//返回的详情信息
        $retdata['Status'] = $orderinfo['LoanStatus'];
        $retdata['Statusname'] = $statusArr[$orderinfo['LoanStatus']];
        $retdata['ApplyTime'] = $orderinfo['ApplyTime'];
        $retdata['YyFkTime'] = $orderinfo['YyFkTime'];
        $retdata['OrderSn'] = $orderinfo['OrderSn'];
        $retdata['ApplyMoney'] = $orderinfo['ApplyMoney'];
        $retdata['AdoptMoney'] = $orderinfo['AdoptMoney'];
        $retdata['FJMoney'] = $orderinfo['FJMoney'];
        $retdata['Interest'] = $orderinfo['Interest'];
        $retdata['ApplyDay'] = $orderinfo['ApplyDay'];
        $retdata['HkTime'] = '';

        if ($orderinfo['LoanType'] == '0') {
            $retdata['LoanType'] = '普通借款';
        } elseif ($orderinfo['LoanType'] == '1') {
            $retdata['LoanType'] = '续借';
        } elseif ($orderinfo['LoanType'] == '2') {
            $retdata['LoanType'] = '分期';
        }
        $retdata['OpenTime'] = '';
        if ($orderinfo['OpenTime']) {
            $retdata['OpenTime'] = $orderinfo['OpenTime'];
        }
        $retdata['CoMoney'] = '';
        if ($orderinfo['CoMoney']) {
            $retdata['CoMoney'] = $orderinfo['CoMoney'];
        }
        //未逾期
        $retdata['overdays'] = '0';
        $retdata['overmoney'] = '0.00';
        //算出逾期金额和逾期天数
        if (in_array($orderinfo['LoanStatus'], array('0', '1', '4', '5'))) {
            $retdata['overdays'] = '0';
            $retdata['overmoney'] = '0.00';
        } elseif ($orderinfo['LoanStatus'] == '2') {
            //查看是否逾期
            //过了当天夜里24点才算逾期
            $overtimes = date('Y-m-d', strtotime($orderinfo['YyFkTime'])) . ' 23:59:59';
            if ($overtimes < date('Y-m-d H:i:s')) {
                //已经逾期了
                $yuqidata = '';
                $yuqidata = getoverinfos($orderinfo['ID']);
                $retdata['overdays'] = $yuqidata['overdays'];
                $retdata['overmoney'] = $yuqidata['famoney'];
            } else {
                //未逾期
                $retdata['overdays'] = '0';
                $retdata['overmoney'] = '0.00';
            }
        } elseif ($orderinfo['LoanStatus'] == '3') {
            //已完成  查询还款记录
            $hkinfos = M(self::T_LOANSHKLIST)->field('ID,FinePayable,HkTime')->where(array('ApplyID' => $orderinfo['ID'], 'IsDel' => '0'))->find();
            if ($hkinfos) {
                $retdata['HkTime'] = $hkinfos['HkTime'];
                if ($hkinfos['FinePayable'] > 0) {
                    //表示逾期了
                    //过了当天夜里24点才算逾期
                    $overtimes = date('Y-m-d', strtotime($orderinfo['YyFkTime'])) . ' 23:59:59';

                    $overdays = strtotime($hkinfos['HkTime']) - strtotime($overtimes);
                    $overdays = $overdays / 86400;
                    $overdays = ceil($overdays);
                    $retdata['overdays'] = $overdays;
                    $retdata['overmoney'] = $hkinfos['FinePayable'];
                }
            } else {
                //如果不存在，则是续借的
                $xjtimes = M('loans_xjapplylist')->where(array('ApplyID' => $orderinfo['ID'], 'Status' => '1', 'PayStatus' => '1'))->getField('XjTime');
                $retdata['HkTime'] = $xjtimes;
            }
        }
        AjaxJson(0, 1, '恭喜您，数据查询成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 还款支付方式
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/hkpaystype
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"0"}
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function hkpaystype()
    {
        $mem = getUserInfo(get_login_info('ID'));
        $retdata = array(
            array('paytype' => '1', 'name' => '支付宝'),
            array('paytype' => '2', 'name' => '微信'),
            array('paytype' => '3', 'name' => '银联'),
        );
        AjaxJson(1, 1, '恭喜您，数据查询成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

//	协议卡解绑接口

    public function jiebang()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        $merchant = M('sys_inteparameter')->where(['ParaName' => 'mchntCd'])->getField('ParaValue');//商户号
        $key = M('sys_inteparameter')->where(['ParaName' => 'key'])->getField('ParaValue');//商户秘钥
        $user_id = $mem['ID'];//用户id
        $protolno = M('renzen_bank')->where(['UserID' => $mem['ID']])->getField(['PROTOCOLNO']);//首次协议交易成功好生成的协议号
        $Fuyou = new \Fuyou\Fuiou;
        $data = $Fuyou->jiebang($merchant, $key, $user_id, $protolno);
        if ($data['status'] == 1) {//银行卡解绑成功
            AjaxJson(0, 1, $data['msg']);
            die;
        } else {
            AjaxJson(0, 0, $data['msg']);
            die;
        }
    }

    /**
     * @功能说明: 还款支付操作
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/hkpay
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222","paytype":"1","traderemark":"我用支付宝182@qq.com账号支付了100元"}}
     *   oid 订单的主键id   ordersn订单编号 paytype 还款类型 1支付宝 2微信 3银联 4代付
     *   traderemark 转账备注信息
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function hkpay()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        if (!in_array($para['paytype'], array('1', '2', '3'))) {
            AjaxJson(0, 0, '还款类型不正确！');
        }
        if ($para['paytype'] != '3' && !$para['traderemark']) {
            AjaxJson(0, 0, '转账备注信息必须提交！');
        }
        $BankNo = '';
        if ($para['paytype'] == '3') {
            //银联还款  查询自己的认证银行卡号
            $baninfos = M('renzen_bank')->field('ID,BankNo')->where(array('UserID' => $mem['ID'], 'Status' => '1', 'IsDel' => '0'))->find();
//			p($baninfos);
            if (!$baninfos) {
                AjaxJson(0, 0, '银行认证信息异常！');
            }
            $BankNo = $baninfos['BankNo'];
        }
        $applyinfo = M('loans_applylist')->field('ID,LoanNo,YyFkTime,BackM,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'LoanStatus' => '2', 'IsDel' => '0'))->find();
//     p($applyinfo);die;
        if (!$applyinfo) {
            AjaxJson(0, 0, '借款订单不存在！');
        }
        //如果还款申请已经提交，并且还处于待审核状态，则不予提交
        $checkresult = M('loans_hklist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkresult) {
            if ($checkresult['PayType'] == '3') {//因为银联支付可以自动获取结果
                //银联支付   把此记录改成审核失败
                $sdata = array(
                    'ShTime' => date('Y-m-d H:i:s'),
                    'Status' => '2',
                );
                M('loans_hklist')->where(array('ID' => $checkresult['ID']))->save($sdata);
            } else {
                AjaxJson(0, 0, '您已经提交支付申请，并在审核中！');
            }
        }
        //如果续借还在审核 不予提交
        $checkxj = M('loans_xjapplylist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkxj) {
            if ($checkxj['PayType'] == '3') {
                //银联支付   把此记录改成审核失败
                $sdata = array(
                    'ShTime' => date('Y-m-d H:i:s'),
                    'Status' => '2',
                );
                M('loans_xjapplylist')->where(array('ID' => $checkxj['ID']))->save($sdata);
            } else {
                AjaxJson(0, 0, '您提交的续借申请还在审核中！');
            }
        }
        //还款操作
        $hkdata = array(
            'UserID' => $mem['ID'],
            'ApplyID' => $applyinfo['ID'],
            'OrderSn' => date(ymd) . rand(1, 9) . date(His) . rand(111, 999),
            'LoanNo' => $applyinfo['LoanNo'],
            'HkTime' => date('Y-m-d H:i:s'),
        );
        //过了当天夜里24点才算逾期
        $overtimes = date('Y-m-d', strtotime($applyinfo['YyFkTime'])) . ' 23:59:59';
        if ($overtimes < date('Y-m-d H:i:s')) {
            $applydata['IsYQ']='1';
            //已经逾期了
            $yuqidata = getoverinfos($applyinfo['ID']);
            $hkdata['TotalMoney'] = $yuqidata['realtotal'];//应付总金额
            $hkdata['FinePayable'] = $yuqidata['famoney'];//应还罚金
        } else {
            //未逾期
            $hkdata['TotalMoney'] = $applyinfo['BackM'];//到期应还
        }
        $hkdata['CostPayable'] = $applyinfo['ApplyMoney'] - $applyinfo['CoMoney'];//应还本金
        //$hkdata['SeviceCostPayable']=$applyinfo['FJMoney'];//应还服务费
        $hkdata['RatePayable'] = $applyinfo['Interest'];//应还本息
        if ($para['paytype'] != '3') {
            $hkdata['TradeRemark'] = $para['traderemark'];
            if ($para['paytype'] == '1') {
                $hkdata['Accounts'] = get_basic_info('Gfaccount');//1支付宝
            } elseif ($para['paytype'] == '2') {
                $hkdata['Accounts'] = get_basic_info('Gfaccountw');//2微信
            }
        }
        $hkdata['PayType'] = $para['paytype'];
        $result = M('loans_hklist')->add($hkdata);//创建还款订单

        if ($result) {
            if ($para['paytype'] == 3) {
                /*富友支付
                 * $TotalMoney=M('loans_hklist')->where(['ID'=>$result])->getField('TotalMoney');//获取需要还款的额度
			    $merchant=M('sys_inteparameter')->where(['ParaName'=>'mchntCd'])->getField('ParaValue');//商户号
				$key=M('sys_inteparameter')->where(['ParaName'=>'key'])->getField('ParaValue');//商户秘钥
		        $user_id=$mem['ID'];//用户id
				$order_no=$applyinfo['LoanNo'];//订单号
				$user_ip='47.93.55.128';//用户ip
				$amt=$TotalMoney*100;//金额
//				$amt=1;//金额
				$protolno=M('renzen_bank')->where(['UserID'=>$mem['ID']])->getField(['PROTOCOLNO']);//首次协议交易成功好生成的协议号
		        $back_url="http://".$_SERVER['HTTP_HOST'].'/index.php/Fuyoupay/hkquery';//支付结果回调地址  并没有很么卵用  没有处理回调信息
//		        p($amt);die;
		//      调用富有协议支付
				$Fuyou=new \Fuyou\Fuiou;
				$data=$Fuyou->newpropay_order($merchant,$key,$user_id,$order_no,$user_ip,$amt,$protolno,$back_url);
                */
                //快钱支付
                $TotalMoney = M('loans_hklist')->where(array('ID' => $result))->getField('TotalMoney');//获取需要还款的额度
                $merchantId = M('sys_inteparameter')->where(array('ParaName' => 'kq_merchantId'))->getField('ParaValue');//商户号
                $loginKey = M('sys_inteparameter')->where(array('ParaName' => 'kq_loginKey'))->getField('ParaValue');//商户秘钥
                $terminalId = M('sys_inteparameter')->where(array('ParaName' => 'kq_terminalId'))->getField('ParaValue');//商户终端号
                $order_no = $applyinfo['LoanNo'];//订单号
                $amount = $TotalMoney;//金额
                $renzen_bank = M('renzen_bank')->where(array('UserID' => $mem['ID']))->find();//银行卡认证信息
                $mem_info = M('mem_info')->where(array('ID' => $mem['ID']))->find();//会员信息

                $data['amount'] = $amount;//金额
                $data['externalRefNumber'] = $order_no;//订单号
                $data['cardHolderName'] = $mem_info['TrueName'];//持卡人姓名
                $data['cardHolderId'] = $mem_info['IDCard'];//持卡人身份证号
                $data['BankNo'] = $renzen_bank['BankNo'];//银行卡号
                $data['BankName'] = $renzen_bank['BankName'];//银行名称
                $data['OpenBankName'] = $renzen_bank['OpenBankName'];//开户支行名称
                $data['Mobile'] = $renzen_bank['YMobile'];//手机号
                $data['merchantId'] = $merchantId;//商户号
                $data['loginKey'] = $loginKey;//key
                $data['terminalId'] = $terminalId;//商户终端号

                //      调用快钱协议支付
                $Kuaiqian = new \Kuaiqian\Kuaiqian;
                $res = $Kuaiqian->collectkuaiqian($data);
                if ($res['status'] == 1) {//银行卡还款成功
                    //          这里要用到事物   提交 稍微操作
                    $model = M();
                    $model->startTrans();//事物开始
                    $applydata = array(
                        'LoanStatus' => '3'
                    );
                    $reS = $model->table('xb_loans_applylist')->where(array('ID' => $para['oid']))->save($applydata);//更改订单状态  为已经完成
                    $status['PayStatus'] = '1';
                    $status['Status'] = '1';
                    $reV = $model->table('xb_loans_hklist')->where(array('ID' => $result))->save($status);//更改还款订单状态为已经还款
//						P($reS);
//						P($reV);
//						P($result);
//                      AjaxJson(0,1,$data['msg']); die;
                    if ($reV && $reS) {
                        $model->commit();//事物提交
                        //		 		还款成功返回状态
                        AjaxJson(0, 1, $res['msg']);
                        die;
                    } else {
                        $model->rollback();//事物回滚
                        //		 		还款失败返回状态
                        AjaxJson(0, 0, $res['msg']);
                        die;
                    }
                } else {
                    $model = M();
                    $model->startTrans();//事物开始
                    $status['PayStatus'] = '0';
                    $status['Status'] = '2';
                    $reV = $model->table('xb_loans_hklist')->where(array('ID' => $result))->save($status);//更改还款订单状态为未还款
                    AjaxJson(0, 0, $res['msg']);
                    die;
                }

            } else {
                AjaxJson(0, 1, '还款记录提交成功，等待审核！');//还款记录提交成功

            }
        } else {
            AjaxJson(0, 0, '还款记录提交失败！');
        }
    }

    /**
     * @功能说明: 获取续借信息(续借选择页-我要续借页面)
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/xjdetails
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222"}}
     *   oid 订单的主键id ordersn订单编号
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function xjdetails()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $applyinfo = M('loans_applylist')->field('ID,LoanNo,YyFkTime,ProductID')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'LoanStatus' => '2', 'IsDel' => '0'))->find();
        if (!$applyinfo) {
            AjaxJson(0, 0, '借款订单不存在！');
        }
        //过了当天夜里24点才算逾期
        $overtimes = date('Y-m-d', strtotime($applyinfo['YyFkTime'])) . ' 23:59:59';
        if ($overtimes < date('Y-m-d H:i:s')) {
            AjaxJson(0, 0, '此单已经逾期，不能续借！');
        }
        //判断第几次续借了
        $xjnumbs = M('loans_applylist')->where(array('LoanNo' => $applyinfo['LoanNo'], 'LoanType' => '1', 'IsDel' => '0'))->count('ID');
        if (!$xjnumbs) {
            $xjnumbs = '0';
        }

        $loansets = M('loans_parameter')->find();
        if ($loansets['MaxRenewSum'] <= $xjnumbs) {
            AjaxJson(0, 0, '此单已经续借多次，不能再续借了！');
        }
        //获取借款期限
        $termlist = M('loans_term')->field('ID,NumDays,ServiceCost')->where(array('Status' => '1', 'IsDel' => '0'))->order('Sort asc,ID desc')->select();
        //获取 快速申请费
        $fast_Applyfee = '0';
        $maxfee = '';
        $currentfee = '';
        //续借参数设置
        $renewsetlist = M('loans_renewset')->field('Nums,Applyfee')->where(array('Status' => '1', 'IsDel' => '0'))->order('Nums asc')->select();
        foreach ($renewsetlist as $k => $v) {
            if ($v['Nums'] == ($xjnumbs + 1)) {
                $currentfee = $v['Applyfee'];
            }
            $maxfee = $v['Applyfee'];
        }
        if ($currentfee) {
            $fast_Applyfee = $currentfee;
        } else {
            $fast_Applyfee = $maxfee;
        }
        //商品续借费
        $goodinfo = M('goods')->field('ServiceCost')->where(array('ID' => $applyinfo['ProductID'], 'IsShelves' => '1', 'IsDel' => '0'))->find();
        if (!$goodinfo) {
            AjaxJson(0, 0, '商品信息异常，暂不能续借！');
        }
        $retdata = array(
            'arrivetime' => date('Y-m-d H:i:s',strtotime($overtimes.'+7 day')),
            'termlist' => $termlist,
            'xjfee' => $fast_Applyfee + $goodinfo['ServiceCost'],
        );
        AjaxJson(1, 1, '恭喜您，数据查询成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 获取续借支付总金额
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/getxjfee
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222","termid":"1"}}
     *   oid 订单的主键id  ordersn订单编号  termid续借期限id
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function getxjfee()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $applyinfo = M('loans_applylist')->field('ID,LoanNo,ProductID')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'LoanStatus' => '2', 'IsDel' => '0'))->find();
        if (!$applyinfo) {
            AjaxJson(0, 0, '借款订单不存在！');
        }
        //判断第几次续借了
        $xjnumbs = M('loans_applylist')->where(array('LoanNo' => $applyinfo['LoanNo'], 'LoanType' => '1', 'IsDel' => '0'))->count('ID');
        if (!$xjnumbs) {
            $xjnumbs = '0';
        }
        //获取借款期限
        $terminfo = M('loans_term')->field('ID,NumDays,ServiceCost')->where(array('ID' => $para['termid'], 'Status' => '1', 'IsDel' => '0'))->find();
        if (!$terminfo) {
            AjaxJson(0, 0, '借款期限异常！');
        }
        //获取 快速申请费
        $fast_Applyfee = '0';
        $maxfee = '';
        $currentfee = '';
        //续借参数设置
        $renewsetlist = M('loans_renewset')->field('Nums,Applyfee')->where(array('Status' => '1', 'IsDel' => '0'))->order('Nums asc')->select();
        foreach ($renewsetlist as $k => $v) {
            if ($v['Nums'] == ($xjnumbs + 1)) {
                $currentfee = $v['Applyfee'];
            }
            $maxfee = $v['Applyfee'];
        }
        if ($currentfee) {
            $fast_Applyfee = $currentfee;
        } else {
            $fast_Applyfee = $maxfee;
        }
        //商品续借费
        $goodinfo = M('goods')->field('ServiceCost')->where(array('ID' => $applyinfo['ProductID'], 'IsShelves' => '1', 'IsDel' => '0'))->find();
        if (!$goodinfo) {
            AjaxJson(0, 0, '商品信息异常，暂不能续借！');
        }
        $retdata = array(
            'xjtotalmoney' => $fast_Applyfee + $terminfo['ServiceCost'] + $goodinfo['ServiceCost'],
        );
        AjaxJson(0, 1, '恭喜您，数据查询成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

    /**
     * @功能说明: 续借支付确认操作(选择支付方式页面)
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/xjpay
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2",,"ordersn":"12352222""termid":"1","paytype":"1","traderemark":"我用支付宝182@qq.com账号支付了100元"}}
     *   oid 订单的主键id  ordersn订单编号  termid续借期限id paytype 支付类型 1支付宝 2微信 3银联 4代付
     *   traderemark 转账备注信息
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function xjpay()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
//		p($para);die;
//		p($mem);die;
        //校验
        if (!in_array($para['paytype'], array('1', '2', '3', '4'))) {
            AjaxJson(0, 0, '还款类型不正确！');
        }
        if ($para['paytype'] != '3' && !$para['traderemark']) {
            AjaxJson(0, 0, '转账备注信息必须提交！');
        }
        $BankNo = '';
        if ($para['paytype'] == '3') {
            //银联还款  查询自己的认证银行卡号
            $baninfos = M('renzen_bank')->field('ID,BankNo')->where(array('UserID' => $mem['ID'], 'Status' => '1', 'IsDel' => '0'))->find();
            if (!$baninfos) {
                AjaxJson(0, 0, '银行认证信息异常！');
            }
            $BankNo = $baninfos['BankNo'];
        }

        $applyinfo = M('loans_applylist')->field('ID,LoanNo,YyFkTime,ProductID')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'LoanStatus' => '2', 'IsDel' => '0'))->find();
        if (!$applyinfo) {
            AjaxJson(0, 0, '借款订单不存在！');
        }
        //过了当天夜里24点才算逾期
        $overtimes = date('Y-m-d', strtotime($applyinfo['YyFkTime'])) . ' 23:59:59';
        if ($overtimes < date('Y-m-d H:i:s')) {
            AjaxJson(0, 0, '此单已经逾期，不能续借！');
        }
        //如果还款还在审核 不予提交
        $checkhks = M('loans_hklist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkhks) {
            if ($checkhks['PayType'] == '3') {
                //银联支付   把此记录改成审核失败
                $sdata = array(
                    'ShTime' => date('Y-m-d H:i:s'),
                    'Status' => '2',
                );
                M('loans_hklist')->where(array('ID' => $checkhks['ID']))->save($sdata);
            } else {
                AjaxJson(0, 0, '您提交的还款申请还在审核中！');
            }
        }

        //判断第几次续借了
        $xjnumbs = M('loans_applylist')->where(array('LoanNo' => $applyinfo['LoanNo'], 'LoanType' => '1', 'IsDel' => '0'))->count('ID');
        if (!$xjnumbs) {
            $xjnumbs = '0';
        }
        $loansets = M('loans_parameter')->find();
        if ($loansets['MaxRenewSum'] <= $xjnumbs) {
            AjaxJson(0, 0, '此单已经续借多次，不能再续借了！');
        }
        //获取借款期限
        $terminfo = M('loans_term')->field('ID,NumDays,ServiceCost')->where(array('ID' => $para['termid'], 'Status' => '1', 'IsDel' => '0'))->find();
        if (!$terminfo) {
            AjaxJson(0, 0, '借款期限异常！');
        }
        //获取 快速申请费
        $fast_Applyfee = '0';
        $maxfee = '';
        $currentfee = '';
        //续借参数设置
        $renewsetlist = M('loans_renewset')->field('Nums,Applyfee')->where(array('Status' => '1', 'IsDel' => '0'))->order('Nums asc')->select();
        foreach ($renewsetlist as $k => $v) {
            if ($v['Nums'] == ($xjnumbs + 1)) {
                $currentfee = $v['Applyfee'];
            }
            $maxfee = $v['Applyfee'];
        }
        if ($currentfee) {
            $fast_Applyfee = $currentfee;
        } else {
            $fast_Applyfee = $maxfee;
        }
        //商品续借费
        $goodinfo = M('goods')->field('ServiceCost')->where(array('ID' => $applyinfo['ProductID'], 'IsShelves' => '1', 'IsDel' => '0'))->find();
        if (!$goodinfo) {
            AjaxJson(0, 0, '商品信息异常，暂不能续借！');
        }

        //如果续借申请已经提交，并且还处于待审核状态，则不予提交
        $checkresult = M('loans_xjapplylist')->field('ID,PayType')->where(array('ApplyID' => $applyinfo['ID'], 'PayStatus' => '0', 'Status' => '0'))->find();
        if ($checkresult) {
            if ($checkresult['PayType'] == '3') {
                //银联支付   把此记录改成审核失败
                $sdata = array(
                    'ShTime' => date('Y-m-d H:i:s'),
                    'Status' => '2',
                );
                M('loans_xjapplylist')->where(array('ID' => $checkresult['ID']))->save($sdata);
            } else {
                AjaxJson(0, 0, '您已经提交续借申请，并在审核中！');
            }
        }
        //续借操作
        $xjdata = array(
            'UserID' => $mem['ID'],
            'ApplyID' => $applyinfo['ID'],
            'OrderSn' => date(ymd) . rand(1, 9) . date(His) . rand(111, 999),
            'LoanNo' => $applyinfo['LoanNo'],
            'LoanDay' => $terminfo['NumDays'],
            'TotalMoney' => $fast_Applyfee + $terminfo['ServiceCost'] + $goodinfo['ServiceCost'],
            'ServiceCost' => $fast_Applyfee + $terminfo['ServiceCost'] + $goodinfo['ServiceCost'],
            'XjTime' => date('Y-m-d H:i:s'),
            'PayType' => $para['paytype'],
        );
        if ($para['paytype'] != '3') {
            $xjdata['TradeRemark'] = $para['traderemark'];
            if ($para['paytype'] == '1') {
                $xjdata['Accounts'] = get_basic_info('Gfaccount');//1支付宝
            } elseif ($para['paytype'] == '2') {
                $xjdata['Accounts'] = get_basic_info('Gfaccountw');//2微信
            }
        }
        $result = M('loans_xjapplylist')->add($xjdata);
        if ($result) {//银联操作
            if ($para['paytype'] == '3') {
//      		echo '银联';die;
                /* 富有支付
			   $merchant=M('sys_inteparameter')->where(['ParaName'=>'mchntCd'])->getField('ParaValue');//商户号
				$key=M('sys_inteparameter')->where(['ParaName'=>'key'])->getField('ParaValue');//商户秘钥
		        $user_id=$mem['ID'];//用户id
				$order_no=$xjdata['OrderSn'];//订单号
				$user_ip='47.93.55.128';//用户ip
				$amt=$xjdata['TotalMoney']*100;//金额
//				$amt=1;//金额
				$protolno=M('renzen_bank')->where(['UserID'=>$mem['ID']])->getField(['PROTOCOLNO']);//首次协议交易成功好生成的协议号
//				$protolno='3QQGN2100011496056YJUG';
		        $back_url="http://".$_SERVER['HTTP_HOST'].'/index.php/Fuyoupay/hkquery';//支付结果回调地址  并没有很么卵用  没有处理回调信息
//		        p($user_id);die;
		//      调用富有协议支付
				$Fuyou=new \Fuyou\Fuiou;
				$data=$Fuyou->newpropay_order($merchant,$key,$user_id,$order_no,$user_ip,$amt,$protolno,$back_url);
			  */
                $merchantId = M('sys_inteparameter')->where(['ParaName' => 'kq_merchantId'])->getField('ParaValue');//商户号
                $loginKey = M('sys_inteparameter')->where(['ParaName' => 'kq_loginKey'])->getField('ParaValue');//商户秘钥
                $terminalId = M('sys_inteparameter')->where(['ParaName' => 'kq_terminalId'])->getField('ParaValue');//商户终端号

                $renzen_bank = M('renzen_bank')->where(['UserID' => $mem['ID']])->find();//银行卡认证信息
                $mem_info = M('mem_info')->where(['ID' => $mem['ID']])->find();//会员信息

                $order_no = $xjdata['OrderSn'];//订单号
                $amount = $xjdata['TotalMoney'];//金额

                $data['amount'] = $amount;//金额
                $data['externalRefNumber'] = $order_no;//订单号
                $data['cardHolderName'] = $mem_info['TrueName'];//持卡人姓名
                $data['cardHolderId'] = $mem_info['IDCard'];//持卡人身份证号
                $data['BankNo'] = $renzen_bank['BankNo'];//银行卡号
                $data['BankName'] = $renzen_bank['BankName'];//银行名称
                $data['OpenBankName'] = $renzen_bank['OpenBankName'];//开户支行名称
                $data['Mobile'] = $renzen_bank['YMobile'];//手机号
                $data['merchantId'] = $merchantId;//商户号
                $data['loginKey'] = $loginKey;//key
                $data['terminalId'] = $terminalId;//商户终端号

                //      调用快钱协议支付
                $Kuaiqian = new \Kuaiqian\Kuaiqian;
                $data = $Kuaiqian->collectkuaiqian($data);

                if ($data['status'] == 1) {//银行卡成功
                    //      	更改订单表时间 加七天
                    $time1 = strtotime($applyinfo['YyFkTime']);
                    $time2 = 60 * 60 * 24 * 7;
                    $time = $time1 + $time2;
                    $days['YyFkTime'] = date('Y-m-d h:i:s', $time);
                    $loans_applylist = M('loans_applylist')->where(array('ID' => $para['oid'], 'LoanNo' => $para['ordersn'], 'LoanStatus' => '2', 'IsDel' => '0'))->save($days);
                    $loans_xjapplylist = M('loans_xjapplylist')->where(array('ID' => $result, 'LoanNo' => $para['ordersn'], 'IsDel' => '0'))->save(['PayStatus' => '1', 'Status' => '1']);
                    if ($loans_applylist & $loans_xjapplylist) {
                        $ddd['result'] = '1';
                        $ddd['message'] = '续借成功！';
                        echo json_encode($ddd);

                    } else {
                        $ddd['result'] = '0';
                        $ddd['message'] = '续借失败！';
                        echo json_encode($ddd);

                    }
                } else {
                    AjaxJson(0, 0, $data['msg']);
                    die;
                }

            } else {//微信支付宝操作

                AjaxJson(0, 1, '续借记录提交成功！');
            }
        } else {
            AjaxJson(0, 0, '续借记录提交失败！');
        }
    }

    /**
     * @功能说明: 获取还款支付总金额
     * @传输方式: 私有token,密文提交，明文返回
     * @提交网址: /center/Order/gethkmoney
     * @提交信息：{"token":"3182F49D44F72708AA00041EF2B0E5E1DEDD50FEC4E36FB12C85FFDA80DD","client":"pc","package":"11","version":"1.1","isaes":"1","data":{"oid":"2","ordersn":"12352222"}}
     *   oid 订单的主键id   ordersn订单编号
     * @返回信息: {'result'=>1,'message'=>'登录密码修改成功!'}
     */
    public function gethkpaymoney()
    {
        $para = get_json_data();//接收参数
        $mem = getUserInfo(get_login_info('ID'));
        //校验
        $orderinfo = M(self::T_LOANSAPPLYLIST)->field('ID,OrderSn,YyFkTime,BackM')->where(array('ID' => $para['oid'], 'OrderSn' => $para['ordersn'], 'UserID' => $mem['ID'], 'LoanStatus' => '2', 'IsDel' => '0'))->find();
        if (!$orderinfo) {
            AjaxJson(0, 0, '订单信息不存在！');
        }
        $retdata = array();//返回的详情信息
        $retdata['ID'] = $orderinfo['ID'];
        $retdata['OrderSn'] = $orderinfo['OrderSn'];

        //查看是否逾期
        //过了当天夜里24点才算逾期
        $overtimes = date('Y-m-d', strtotime($orderinfo['YyFkTime'])) . ' 23:59:59';
        if ($overtimes < date('Y-m-d H:i:s')) {
            //已经逾期了
            $yuqidata = '';
            $yuqidata = getoverinfos($orderinfo['ID']);
            $retdata['TotalMoney'] = $yuqidata['realtotal'];
        } else {
            //未逾期
            $retdata['TotalMoney'] = $orderinfo['BackM'];
        }
        AjaxJson(0, 1, '恭喜您，数据查询成功！', $retdata, 1, $mem['KEY'], $mem['IV']);
    }

}
