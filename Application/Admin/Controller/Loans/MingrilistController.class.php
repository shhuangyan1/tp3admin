<?php
/**
 * 功能说明: 借款申请控制器
 */
namespace Admin\Controller\Loans;

use Admin\Controller\System\BaseController;
use Mozhang\Mozhang;
use XBCommon;
class MingrilistController extends BaseController{
    const T_TABLE='loans_applylist';
    const T_HKLIST='loans_hklist';
    const T_MEMINFO='mem_info';
    const T_ADMIN='sys_administrator';
    const T_CARDS='renzen_cards';//身份证认证表
    const T_MOBILE='renzen_mobile';//手机认证表
    const T_ALIPAY='renzen_alipay';//支付宝认证表
    const T_TAOBAO='renzen_taobao';//淘宝认证表
    const T_MEMBERINFO='renzen_memberinfo';//基本信息认证表
    const T_SOCIAL='renzen_social';//社交认证表
    const T_BANK='renzen_bank';//银行卡认证表

    public function _initialize(){
        parent::_initialize();
        $this->LoanStatus = array(0=>"申请中",1=>"放款中",2=>"已放款",3=>"已完成",4=>"已取消",5=>"已拒绝",6=>"等待银行打款",7=>"打款失败,处理中");
        $this->Status = array(0=>'待审核',1=>'审核成功',2=>'审核失败');
        $this->LoanType = array(0=>'普通',1=>'续借',2=>'分期');
    }



//借款列表
    public function index(){
        $kefuArr=M(self::T_ADMIN)->field('ID,TrueName')->where(array('RoleID'=>'7','Status'=>'1','IsDel'=>'0'))->select();
        $RoleID=$_SESSION['AdminInfo']['RoleID'];
        $this->assign(array(
            'LoanStatus'=>$this->LoanStatus,
            'Status'=>$this->Status,
            'kefuArr'=>$kefuArr,
            'RoleID'=>$RoleID,
        ));
        $this->display();
    }

    //黑名单独立页面
    public function heimingdan(){
        $id=I('post.ID',0,'intval');//订单id
        $UserID=M('loans_applylist')->field('UserID')->where(array('ID'=>$id,'IsDel'=>'0'))->find();//根据订单id去获取用户id
        $jumpurl="http://".$_SERVER['HTTP_HOST'].'/index.php?m=home&c=index&a=heimingdanyemian&id='.$UserID['UserID'];
        $this->ajaxReturn(1,$jumpurl);

    }
    //有盾报告独立页面
    public function ydbgdy(){
        $id=I('post.ID',0,'intval');//订单id
        $UserID=M('loans_applylist')->field('UserID')->where(array('ID'=>$id,'IsDel'=>'0'))->find();//根据订单id去获取用户id
        $dataID=M(self::T_CARDS)->where(array("UserID"=>$UserID['UserID']))->getField('ID');//根据用户id去获取身份证认证表id
        $jumpurl="http://".$_SERVER['HTTP_HOST'].'/index.php?m=home&c=index&a=baogao&id='.$dataID;
        $this->ajaxReturn(1,$jumpurl);
    }

    //魔蝎魔杖报告独立页面
    public function mzbg(){
        $id=I('post.ID',0,'intval');//订单id
        $UserID=M('loans_applylist')->field('UserID')->where(array('ID'=>$id,'IsDel'=>'0'))->find();//根据订单id去获取用户id
        $dataID=M('moxie_mozhang')->where(array("UserID"=>$UserID['UserID']))->getField('ID');//根据用户id去获取魔杖表id
        if(!$dataID){
            $data=M(self::T_MEMINFO)->where(array("ID"=>$UserID['UserID']))->find();
            $mozhang = new \Mozhang\Mozhang;
            $bgdata = $mozhang -> getMoZhangContent($data['TrueName'],$data['IDCard'],$data['Mobile']);
            if($bgdata){
                $sdata=array(
                    'UserID'=>$UserID['UserID'],
                    'UpdateTime'=>date('Y-m-d H:i:s'),
                    'BgData'=>$bgdata,
                );
                M('moxie_mozhang')->add($sdata);
                $dataID = M()->getLastInsID();
            }
        }
        $jumpurl="http://".$_SERVER['HTTP_HOST'].'/index.php?m=home&c=index&a=mozhang&id='.$dataID;
        $this->ajaxReturn(1,$jumpurl);
    }

    //手机认证 独立页面
    public function yysbgdy(){

        $id=I('post.ID',0,'intval');//订单id
        $UserID=M('loans_applylist')->field('UserID')->where(array('ID'=>$id,'IsDel'=>'0'))->find();//根据订单id去获取用户id
        $data=M('renzen_mobile')->field('mistr,TaskID')->where(array('UserID'=>$UserID['UserID']))->find();//根据用户id去找tasdid
        if(!$data['TaskID']){
            $this->ajaxReturn(0,'暂不能查看报告!');
        }
        $baogaourl=M('sys_inteparameter')->where(array('ParaName'=>'baogaomoxie'))->field('ParaValue')->find();//获取url
        $dataaa=M(self::T_SOCIAL)->where(array('UserID'=>$UserID['UserID']))->getField('Contents');
        $dataaa=unserialize($dataaa);
        $jumpurl=$baogaourl['ParaValue'].$data['mistr'].'&contact='.$dataaa['qinshu']['0']['tel'].':'.$dataaa['qinshu']['0']['name'].':'.$dataaa['qinshu']['0']['guanxi'].','.$dataaa['shehui']['0']['tel'].':'.$dataaa['shehui']['0']['name'].':'.$dataaa['shehui']['0']['guanxi'];
        $this->ajaxReturn(1,$jumpurl);
    }
    //淘宝报告独立页面
    public function mzsqrz(){
        $id=I('post.ID',0,'intval');//订单id
        $UserID=M('loans_applylist')->field('UserID')->where(array('ID'=>$id,'IsDel'=>'0'))->find();//根据订单id去获取用户id
        $data=M('renzen_taobao')->field('mistr,TaskID')->where(array('UserID'=>$UserID['UserID']))->find();//根据用户id去找tasdid
        if(!$data['TaskID']){
            $this->ajaxReturn(0,'暂不能查看报告!');
        }
        $jumpurl='https://tenant.51datakey.com/taobao/report_data?data='.$data['mistr'];
        $this->ajaxReturn(1,$jumpurl);

    }

    /**
     * 后台用户管理的列表数据获取  借款记录
     * @access   public
     * @return   object    返回json数据
     */
    public function DataList(){
        $page=I('post.page',1,'intval');
        $rows=I('post.rows',20,'intval');
        $sort=I('post.sort');
        $order=I('post.order');
        if ($sort && $order){
            $sort=$sort.' '.$order;
        }else{
            $sort='ID desc';
        }

        //搜索条件
        $TrueName=I('post.TrueName','');
        if($TrueName){
            $memidArr=M(self::T_MEMINFO)->field('ID')->where(array('TrueName'=>array('like','%'.$TrueName.'%')))->select();
            if($memidArr){
                $memids=array();
                foreach($memidArr as $k=>$v){
                    $memids[]=$v['ID'];
                }
                //$memids=array_column($memidArr, 'ID');
                $where['UserID']=array('in',$memids);
            }else{
                $where['UserID']=array('eq','0');
            }
        }
        $Mobile=I('post.Mobile','');
        if($Mobile){
            $memidArr='';
            $memidArr=M(self::T_MEMINFO)->field('ID')->where(array('Mobile'=>array('eq',$Mobile)))->select();
            if($memidArr){
                $memids=array();
                foreach($memidArr as $k=>$v){
                    $memids[]=$v['ID'];
                }
                $where['UserID']=array('in',$memids);
            }else{
                $where['UserID']=array('eq','0');
            }
        }
        $LoanStatus=I('post.LoanStatus',-5,'int');
        if($LoanStatus!=-5){
            $where['LoanStatus']=$LoanStatus;
        }
        $LoanNo=I('post.LoanNo','');
        if($LoanNo){
            $where['LoanNo']=$LoanNo;
        }
        $OrderSn=I('post.OrderSn','');
        if($OrderSn){
            $where['OrderSn']=$OrderSn;
        }
        $Status=I('post.Status',-5,'int');
        if($Status!=-5){
            $where['Status']=$Status;
        }
        $SqAdminID=I('post.SqAdminID',-5,'int');
        if($SqAdminID!=-5){
            $where['SqAdminID']=$SqAdminID;
        }
        //审核时间
        $shStartTime=date("Y-m-d",strtotime("+1 day"));  //按时间查询
        $shEndTime=date("Y-m-d",strtotime("+1 day"));
        $ToStartTime=$shStartTime;
        $ToEndTime=date('Y-m-d',strtotime($shEndTime."+1 day"));
        if($shStartTime!=null){
            if($shEndTime!=null){
                //有开始时间和结束时间
                $where['YyFkTime']=array('between',$ToStartTime.','.$ToEndTime);
            }else{
                //只有开始时间
                $where['YyFkTime']=array('egt',$ToStartTime);
            }
        }else{
            //只有结束时间
            if($shEndTime!=null){
                $where['YyFkTime']=array('elt',$ToEndTime);
            }
        }
        //不是管理员的话，只能看到自己的单子
        if($_SESSION['AdminInfo']['RoleID']!='2'){
            if($_SESSION['AdminInfo']['RoleID']=='10'){
                //催收专员
                $where['CsadminID']=$_SESSION['AdminInfo']['AdminID'];
            }elseif($_SESSION['AdminInfo']['RoleID']=='7'){
                //客服专员
                $where['SqAdminID']=$_SESSION['AdminInfo']['AdminID'];
            }elseif($_SESSION['AdminInfo']['RoleID']=='8'){
                //放款专员
                $where['FKadminID']=$_SESSION['AdminInfo']['AdminID'];
            }
        }

        $where['IsDel']=0;
//		  $where['LoanStatus']=0;
        //查询的数据表字段名
        $col='ID,UserID,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney,ApplyDay,ApplyTime,LoanStatus,BackM,OrderSn,LoanNo,YyFkTime,SqAdminID,LoanType,Status,ServiceID,ShTime';//默认全字段查询

        //获取主表的数据
        $query=new XBCommon\XBQuery;
        $array=$query->GetDataList(self::T_TABLE,$where,$page,$rows,$sort,$col);

        $LoanStatusArr = $this->LoanStatus;
        $StatusArr = $this->Status;
        $LoanTypeArr = $this->LoanType;
//		 p($array);die;
        //重组数据返还给前段
        $result=array();
        if($array['rows']){
            foreach ($array['rows'] as $val) {
                $meminfo=M(self::T_MEMINFO)->field('MemAccount,TrueName,Mobile')->where(array('ID'=>$val['UserID']))->find();
                $val['MemAccount']=$meminfo['MemAccount'];
                $val['TrueName']=$meminfo['TrueName'];
                $val['Mobile']=$meminfo['Mobile'];
                $val['SqAdminID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['SqAdminID']),'TrueName');
                $val['ServiceID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['ServiceID']),'TrueName');
                //查询还款时间 T_HKLIST
                if($val['LoanStatus']=='3' && $val['LoanType']=='0'){
                    //普通
                    $val['RealFkTime']=M(self::T_HKLIST)->where(array('ApplyID'=>$val['ID'],'PayStatus'=>'1','Status'=>'1','IsDel'=>'0'))->getField('HkTime');
                }elseif($val['LoanType']=='1'){
                    //续借
                    $val['RealFkTime']='未订单';
                }
                //统计借款次数 必须是完整的订单
                $val['LoanNumbs']=M(self::T_TABLE)->where(array('UserID'=>$val['UserID'],'LoanStatus'=>'3','IsDel'=>'0'))->count('ID');
                //设置显示颜色
                if($val['LoanNumbs']>0){
                    //表示 不止是一次借了
                    //判断有没有逾期记录
                    $yuqicheck='';
                    $yqwhere=array();
                    $yqwhere['UserID']=array('eq',$val['UserID']);
                    $yqwhere['IsDel']=array('eq','0');
                    $yqwhere['_string']="IsYQ='1' OR CONCAT(DATE_FORMAT(YyFkTime,'%Y-%m-%d'),' 23:59:59')<'".date('Y-m-d H:i:s')."' AND LoanStatus='2'";
                    $yuqicheck=M(self::T_TABLE)->where($yqwhere)->count('ID');
                    if($yuqicheck){
                        //有逾期记录
                        $val['TrueName']='<span style="color:red;">'.$val['TrueName'].'</span>';
                        $val['Mobile']='<span style="color:red;">'.$val['Mobile'].'</span>';
                    }else{
                        //无逾期记录
                        $val['TrueName']='<span style="color:blue;">'.$val['TrueName'].'</span>';
                        $val['Mobile']='<span style="color:blue;">'.$val['Mobile'].'</span>';
                    }
                }

                $val['LoanStatus']=$LoanStatusArr[$val['LoanStatus']];
                $val['Status']=$StatusArr[$val['Status']];
                $val['LoanType']=$LoanTypeArr[$val['LoanType']];
                $TgAdmin =M('mem_info')->where(array('ID'=>$val['UserID']))->getField('TgAdminID');
                $val['TgAdminID']=M('tg_admin')->where(array('ID'=>$TgAdmin))->getField('Name');
                $result['rows'][]=$val;
            }
            $result['total']=$array['total'];
        }
        $this->ajaxReturn($result);
    }
    /*详情*/
    public function detail(){
        $ID=I('request.ID');
        $infos=M(self::T_TABLE)->alias('a')
            ->field('a.*,b.MemAccount,b.Mobile,b.TrueName')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.ID'=>$ID))->find();
        if($infos['ServiceID']){
            $infos['ServiceID']=M(self::T_ADMIN)->where(array('ID'=>$infos['ServiceID']))->getField('TrueName');
        }
        $infos['sjhkmoney']='0';
        if($infos['LoanStatus']=='3'){
            $sjhkmoney='';
            $sjhkmoney=M('loans_hklist')->where(array('ApplyID'=>$infos['ID'],'PayStatus'=>'1','Status'=>'1'))->getField('TotalMoney');
            if($sjhkmoney){
                $infos['sjhkmoney']=$sjhkmoney;//还款
            }else{
                //续借
                $infos['sjhkmoney']=M('loans_xjapplylist')->where(array('ApplyID'=>$infos['ID'],'PayStatus'=>'1','Status'=>'1'))->getField('TotalMoney');
            }
        }
        $LoanStatusArr=$this->LoanStatus;
        $StatusArr=$this->Status;
        $LoanTypeArr=$this->LoanType;
        $infos['LoanStatus2']=$infos['LoanStatus'];
        $infos['LoanStatus']=$LoanStatusArr[$infos['LoanStatus']];
        $infos['Status']=$StatusArr[$infos['Status']];
        $infos['LoanType']=$LoanTypeArr[$infos['LoanType']];
        //身份证认证
        $cardinfos=M('renzen_cards')->alias('a')
            ->field('a.ID,a.Yddatas,a.Status,a.RenzTime,a.CardFace,a.CardSide,a.Cardschi,b.Mobile,b.TrueName,b.IDCard')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID'=>$infos['UserID']))->find();
        if($cardinfos['Yddatas']){
            $cardinfos['Yddatas']=unserialize($cardinfos['Yddatas']);
        }
        $cardimgArr=array();
        $cardimgArr[]=$cardinfos['CardFace'];
        $cardimgArr[]=$cardinfos['CardSide'];
        $cardimgArr[]=$cardinfos['Cardschi'];
        //手机认证
        $mobileinfos=M('renzen_mobile')->alias('a')
            ->field('a.ZUserName,a.OpenDate,a.AccountBalance,a.Status,a.RenzTime,b.Mobile,b.TrueName')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID'=>$infos['UserID']))->find();
//      //支付宝认证
//      $alipayinfos=M('renzen_alipay')->alias('a')
//                 ->field('a.TaobaoName,a.Balance,a.HuabeiBalance,a.HuabeiLimit,a.HuabeiRet,a.ZFBMobile,a.Email,a.RenzTime,a.Status,b.Mobile,b.TrueName')
//                 ->join('left join xb_mem_info b on a.UserID=b.ID')
//                 ->where(array('a.UserID'=>$infos['UserID']))->find();
//      //淘宝认证
//      $taobaoinfos=M('renzen_taobao')->alias('a')
//                 ->field('a.Receivers,a.zhimafen,a.BDMobile,a.Levels,a.Balance,a.JBalance,a.UserName,a.XFQuote,a.XYQuote,a.ZmScore,a.JieBei,a.YZStatus,a.RenzTime,a.Status,b.Mobile,b.TrueName')
//                 ->join('left join xb_mem_info b on a.UserID=b.ID')
//                 ->where(array('a.UserID'=>$infos['UserID']))->find();
//				   p($taobaoinfos);
        //基本信息认证
        $jibeninfos=M('renzen_memberinfo')->alias('a')
            ->field('a.*,b.Mobile,b.TrueName,b.NickName,b.Sex')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID'=>$infos['UserID']))->find();
        //社交认证
        $socialinfos=M('renzen_social')->field('ID,QQ,WeChat,Contents,Status,RenzTime')->where(array('UserID'=>$infos['UserID'],'IsDel'=>'0'))->find();
        if($socialinfos['Contents']){
            $socialinfos['Contents']=unserialize($socialinfos['Contents']);
        }
        //银行卡认证
        $bankinfos=M('renzen_bank')->alias('a')
            ->field('a.BankName,a.OpenBankName,a.BankNo,a.Address,a.YMobile,a.RenzTime,a.Status,b.TrueName,b.IDCard')
            ->join('left join xb_mem_info b on a.UserID=b.ID')
            ->where(array('a.UserID'=>$infos['UserID']))->find();
//		淘宝认证数据
        $UserID=M('loans_applylist')->where(array("ID"=>$ID))->getField('UserID');//根据订单id查找用户id

        $re=M('renzen_taobao')
            ->field('Receivers,zhimafen')
            ->where(array('UserID'=>$UserID))->find();

        $res=json_decode($re['Receivers'],1);
        $this->assign('cinfos',$res);//淘宝认证数据

        $this->assign('zhimafen',$re['zhimafen']);//芝麻分
        $yue=$res['alipaywealth']['balance']/100;
        $this->assign('yue',$yue);//余额
        $yueb=$res['alipaywealth']['total_quotient']/100;
        $this->assign('yueb',$yueb);//余额宝
        $ljsy=$res['alipaywealth']['total_profit']/100;
        $this->assign('ljsy',$ljsy);//余额宝累计收益
        $hbkyed=$res['alipaywealth']['huabei_creditamount']/100;
        $this->assign('hbkyed',$hbkyed);//花呗可用额度
        $hbsxed=$res['alipaywealth']['huabei_totalcreditamount']/100;
        $this->assign('hbsxed',$hbsxed);//花呗可用额度
        $this->assign(array(
            'infos'=>$infos,
            'cardinfos'=>$cardinfos,
            'cardimgArr'=>$cardimgArr,
            'mobileinfos'=>$mobileinfos,
//            'alipayinfos'=>$alipayinfos,
//          'taobaoinfos'=>$taobaoinfos,
            'jibeninfos'=>$jibeninfos,
            'socialinfos'=>$socialinfos,
            'bankinfos'=>$bankinfos,
        ));
        $this->display();
//	p($res);
    }
    //转单页面
    public function zorder(){
        $id=I('get.ID',0,'intval');
        $res=M(self::T_TABLE)->where(array("ID"=>$id))->find();
        $kefuArr=M(self::T_ADMIN)->field('ID,TrueName')->where(array('RoleID'=>'7','Status'=>'1','IsDel'=>'0'))->select();
        $this->assign(array(
            'res'=>$res,
            'kefuArr'=>$kefuArr,
        ));
        $this->display();
    }
    //转单保存
    public function zordersave(){
        $ID=I('post.ID','');
        $SqAdminID=I('post.SqAdminID','0');
        if(!$SqAdminID){
            $this->ajaxReturn(0,'很抱歉，请选择专属客服！');
        }
        $result=M(self::T_TABLE)->where(array('ID'=>$ID))->save(array('SqAdminID'=>$SqAdminID));
        if($result){
            $this->ajaxReturn(1,'恭喜您，转单成功成功！');
        }else{
            $this->ajaxReturn(0,'很抱歉，转单失败！');
        }
    }
    //导出功能
    public function exportexcel(){
        $sort=I('post.sort');
        $order=I('post.order');
        if ($sort && $order){
            $sort=$sort.' '.$order;
        }else{
            $sort='ID desc';
        }

        //搜索条件
        $TrueName=I('post.TrueName','');
        if($TrueName){
            $memidArr=M(self::T_MEMINFO)->field('ID')->where(array('TrueName'=>array('like','%'.$TrueName.'%')))->select();
            if($memidArr){
                $memids=array();
                foreach($memidArr as $k=>$v){
                    $memids[]=$v['ID'];
                }
                //$memids=array_column($memidArr, 'ID');
                $where['UserID']=array('in',$memids);
            }else{
                $where['UserID']=array('eq','0');
            }
        }
        $Mobile=I('post.Mobile','');
        if($Mobile){
            $memidArr='';
            $memidArr=M(self::T_MEMINFO)->field('ID')->where(array('Mobile'=>array('eq',$Mobile)))->select();
            if($memidArr){
                $memids=array();
                foreach($memidArr as $k=>$v){
                    $memids[]=$v['ID'];
                }
                $where['UserID']=array('in',$memids);
            }else{
                $where['UserID']=array('eq','0');
            }
        }
        $LoanStatus=I('post.LoanStatus',-5,'int');
        if($LoanStatus!=-5){
            $where['LoanStatus']=$LoanStatus;
        }
        $LoanNo=I('post.LoanNo','');
        if($LoanNo){
            $where['LoanNo']=$LoanNo;
        }
        $OrderSn=I('post.OrderSn','');
        if($OrderSn){
            $where['OrderSn']=$OrderSn;
        }
        $Status=I('post.Status',-5,'int');
        if($Status!=-5){
            $where['Status']=$Status;
        }
        $SqAdminID=I('post.SqAdminID',-5,'int');
        if($SqAdminID!=-5){
            $where['SqAdminID']=$SqAdminID;
        }
        //审核时间
        $shStartTime=I('post.shStartTime');  //按时间查询
        $shEndTime=I('post.shEndTime');
        $ToStartTime=$shStartTime;
        $ToEndTime=date('Y-m-d',strtotime($shEndTime."+1 day"));
        if($shStartTime!=null){
            if($shEndTime!=null){
                //有开始时间和结束时间
                $where['ShTime']=array('between',$ToStartTime.','.$ToEndTime);
            }else{
                //只有开始时间
                $where['ShTime']=array('egt',$ToStartTime);
            }
        }else{
            //只有结束时间
            if($shEndTime!=null){
                $where['ShTime']=array('elt',$ToEndTime);
            }
        }
        //申请时间
        $sqStartTime=I('post.sqStartTime');  //按时间查询
        $sqEndTime=I('post.sqEndTime');
        $ToStartTime=$sqStartTime;
        $ToEndTime=date('Y-m-d',strtotime($sqEndTime."+1 day"));
        if($sqStartTime!=null){
            if($sqEndTime!=null){
                //有开始时间和结束时间
                $where['ApplyTime']=array('between',$ToStartTime.','.$ToEndTime);
            }else{
                //只有开始时间
                $where['ApplyTime']=array('egt',$ToStartTime);
            }
        }else{
            //只有结束时间
            if($sqEndTime!=null){
                $where['ApplyTime']=array('elt',$ToEndTime);
            }
        }

        $where['IsDel']=0;
        //查询的数据表字段名
        $col='ID,UserID,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney,ApplyDay,ApplyTime,LoanStatus,BackM,OrderSn,LoanNo,YyFkTime,SqAdminID,LoanType,Status,ServiceID,ShTime';//默认全字段查询

        //获取主表的数据
        $query=new XBCommon\XBQuery;
        $array['rows'] =M(self::T_TABLE)->where($where)->order($sort)->select();

        $LoanStatusArr = $this->LoanStatus;
        $StatusArr = $this->Status;
        $LoanTypeArr = $this->LoanType;
        //重组数据返还给前段
        $result=array();
        if($array['rows']){
            foreach ($array['rows'] as $val) {
                $meminfo=M(self::T_MEMINFO)->field('MemAccount,TrueName,Mobile')->where(array('ID'=>$val['UserID']))->find();
                $val['MemAccount']=$meminfo['MemAccount'];
                $val['TrueName']=$meminfo['TrueName'];
                $val['Mobile']=$meminfo['Mobile'];
                $val['SqAdminID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['SqAdminID']),'TrueName');
                $val['ServiceID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['ServiceID']),'TrueName');
                //查询还款时间 T_HKLIST
                if($val['LoanStatus']=='3' && $val['LoanType']=='0'){
                    //普通
                    $val['RealFkTime']=M(self::T_HKLIST)->where(array('ApplyID'=>$val['ID'],'PayStatus'=>'1','Status'=>'1','IsDel'=>'0'))->getField('HkTime');
                }elseif($val['LoanType']=='1'){
                    //续借
                    $val['RealFkTime']='未订单';
                }
                $val['LoanStatus']=$LoanStatusArr[$val['LoanStatus']];
                $val['Status']=$StatusArr[$val['Status']];
                $val['LoanType']=$LoanTypeArr[$val['LoanType']];
                $result['rows'][]=$val;
            }
        }
        //导出拼装
        $html = '<table cellpadding="1" cellspacing="1" border="1" width="100%" bgcolor="#000000;">
            <tr bgcolor="#FFFFFF">
                <td bgcolor="#FFFFFF" align="center" _REQUEST>序号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>真实姓名</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>手机号码</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>商品金额</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>收购价格</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>撮合费</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>息费</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>优惠劵金额</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请天数</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请时间</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请状态</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>到期应还</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>订单号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请号</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>预约还款时间</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>实际还款时间</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>专属客服</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>申请类型</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>审核状态</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>审核人</td>
                <td bgcolor="#FFFFFF" align="center" _REQUEST>审核时间</td>
            </tr>';

        foreach($result['rows'] as $key=>$row){
            $html .= '<tr bgcolor="#FFFFFF">
                <td bgcolor="#FFFFFF" align="center" >'.intval($key+1).'</td>
                <td bgcolor="#FFFFFF" align="center">'.$row['TrueName'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['Mobile'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['ApplyMoney'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['AdoptMoney'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['FJMoney'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['Interest'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['CoMoney'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['ApplyDay'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['ApplyTime'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['LoanStatus'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['BackM'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['OrderSn'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['LoanNo'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['YyFkTime'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['RealFkTime'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['SqAdminID'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['LoanType'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['Status'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['ServiceID'].'</td>
                <td bgcolor="#FFFFFF" align="center" >'.$row['ShTime'].'</td>
            </tr>';
        }

        $html .= '</table>';
        $str_filename = date('Y-m-d', time()).'借款申请列表';
        //$str_filename = iconv('UTF-8', 'GB2312//IGNORE',$str_filename);
        $html = iconv('UTF-8', 'GB2312//IGNORE',$html);
        ob_end_clean();//清除缓存区的内容
        header("Content-type: application/vnd.ms-excel; charset=GBK");
        //header('Content-Type:text/html;charset=utf-8');
        header("Content-Disposition: attachment; filename=$str_filename.xls");
        echo $html;
        exit;
    }
    //匹配通话
    public function getpp(){
        $id=I('post.ID',0,'intval');
        $UserID=M('loans_applylist')->where(array('ID'=>$id))->getField('UserID');

        $mobileinfos=M('renzen_mobile')->field('ID,UserID,CallBill')->where(array('UserID'=>$UserID,'IsDel'=>'0'))->find();
        if(!$mobileinfos['CallBill']){
            $this->ajaxReturn(0,'暂未获取到通话记录!');
        }
        //查询 社交认证表 中的手机通讯录
        $socialinfo=M('renzen_social')->field('ID,Phonelist')->where(array('UserID'=>$mobileinfos['UserID'],'IsDel'=>'0'))->find();
        if(!$socialinfo['Phonelist']){
            $this->ajaxReturn(0,'暂未获取到手机通讯录');
        }
        //进行数据匹配
        $callbills=unserialize($mobileinfos['CallBill']);
        $phonelists=unserialize($socialinfo['Phonelist']);
        foreach($phonelists as $k=>$v){
            $sums='0';//次数
            foreach($callbills as $k2=>$v2){
                if($v['tel']==$v2['tel']){
                    $sums++;
                }
            }
            $phonelists[$k]['sums']=$sums;
            $phonelists[$k]['updatetime']=date('Y-m-d H:i:s');
        }
        $phonelists=serialize($phonelists);
        $updata=array(
            'Phonelist'=>$phonelists,
        );
        $result=M('renzen_social')->where(array('ID'=>$socialinfo['ID']))->save($updata);
        if($result){
            $result2=M('renzen_mobile')->where(array('ID'=>$id))->save(array('IsPP'=>'1'));
            $this->ajaxReturn(0,'匹配成功!');
        }else{
            $this->ajaxReturn(0,'匹配失败!');
        }
    }
    /**
     *通话记录
     */
    public function CallBill(){
        $listID=I('get.listID');//借款申请id
        $tel=I('post.tel');
        $contype=I('post.contype','-5');
        if(!empty($listID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $start=($page-1)*$rows;//开始截取位置
            $UserID=M('loans_applylist')->where(array("ID"=>$listID))->getField('UserID');
            $CallBill=M('renzen_mobile')->where(array("UserID"=>$UserID))->getField('CallBill');
            if($CallBill){
                $CallBill=json_decode($CallBill,1);
                $CallBill=$CallBill['calls'];
                //搜索条件
                if($tel){
                    foreach($CallBill as $k=>$v){
                        if($v['tel']!=$tel){
                            unset($CallBill[$k]);
                        }
                    }
                }
                if($contype!='-5'){
                    if($contype=='1'){
                        //主叫
                        foreach($CallBill as $k=>$v){
                            if($v['contype']!='主叫'){
                                unset($CallBill[$k]);
                            }
                        }
                    }elseif($contype=='2'){
                        //被叫
                        foreach($CallBill as $k=>$v){
                            if($v['contype']!='被叫'){
                                unset($CallBill[$k]);
                            }
                        }
                    }
                }
                $data=array();
                foreach ($CallBill as $k => $v) {
                    foreach ($v['items'] as $kk => $vv) {
                        $data[]=$vv;
                    }
                }
//              //数据分页
                $array='';
                $array=array_slice($data,$start,$rows);
                $result=array();
                if($array){
                    foreach ($array as $val){

                        $result['rows'][]=$val;
                    }
                    $result['total']=count($data);
                }
//				p($result);die;


                $this->ajaxReturn($result);

//              $CallBill=unserialize($CallBill);
//              //搜索条件
//              if($tel){
//                  foreach($CallBill as $k=>$v){
//                      if($v['tel']!=$tel){
//                          unset($CallBill[$k]);
//                      }
//                  }
//              }
//              if($contype!='-5'){
//                  if($contype=='1'){
//                      //主叫
//                      foreach($CallBill as $k=>$v){
//                          if($v['contype']!='主叫'){
//                              unset($CallBill[$k]);
//                          }
//                      }
//                  }elseif($contype=='2'){
//                      //被叫
//                      foreach($CallBill as $k=>$v){
//                          if($v['contype']!='被叫'){
//                              unset($CallBill[$k]);
//                          }
//                      }
//                  }
//              }
//              //数据分页
//              $array='';
//              $array=array_slice($CallBill,$start,$rows);
//              $result=array();
//              if($array){
//                  foreach ($array as $val){
//                      $result['rows'][]=$val;
//                  }
//                  $result['total']=count($CallBill);
//              }
//              $this->ajaxReturn($result);
            }
        }
    }
    /**
     *手机通讯录
     */
    public function Phonelist(){
        $listID=I('get.listID');//借款申请id
        $name=I('post.name','');
        $tel=I('post.tel','');
        //排序
        $sort=I('post.sort');
        $order=I('post.order');
        if(!empty($listID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $start=($page-1)*$rows;//开始截取位置
            $UserID=M('loans_applylist')->where(array("ID"=>$listID))->getField('UserID');

            $Phonelist=M('renzen_social')->where(array("UserID"=>$UserID))->getField('Phonelist');
            if($Phonelist){
                $Phonelist=unserialize($Phonelist);
                //排序功能
                if($sort=='sums'){
                    if($order=='desc'){
                        $Phonelist=$this->arraySequence($Phonelist, 'sums', $sort = 'SORT_DESC');
                    }elseif($order=='asc'){
                        $Phonelist=$this->arraySequence($Phonelist, 'sums', $sort = 'SORT_ASC');
                    }
                }
                //搜索
                if($name){
                    foreach($Phonelist as $k=>$v){
                        if(strpos($v['name'],$name)===false){
                            unset($Phonelist[$k]);
                        }
                    }
                }
                if($tel){
                    foreach($Phonelist as $k=>$v){
                        if($v['tel']!=$tel){
                            unset($Phonelist[$k]);
                        }
                    }
                }
                //数据分页
                $array='';
                $array=array_slice($Phonelist,$start,$rows);
                $result=array();
                if($array){
                    foreach ($array as $val){
                        $result['rows'][]=$val;
                    }
                    $result['total']=count($Phonelist);
                }
                $this->ajaxReturn($result);
            }
        }
    }
    //收货地址
    public function saddreslist(){
        $listID=I('get.listID');//借款申请id
        if(!empty($listID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $start=($page-1)*$rows;//开始截取位置


            $UserID=M('loans_applylist')->where(array("ID"=>$listID))->getField('UserID');

            $Receivers=M('renzen_taobao')->where(array("UserID"=>$UserID))->getField('Receivers');
            if($Receivers){
                $Receivers=json_decode($Receivers,1);
//          	P($Receivers);die;
                $data=$Receivers['deliveraddress'];
//			   p($data);

                //数据分页
                $array='';
                $array=array_slice($data,$start,$rows);
                $result=array();
                if($array){
                    foreach ($array as $val){
                        $result['rows'][]=$val;
                    }
                    $result['total']=count($data);
                }
                $this->ajaxReturn($result);
            }
        }
    }

    //短信获取
    public function duanxinlist(){
        $listID=I('get.listID');//借款申请id
//      p($listID);die;
        if(!empty($listID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $start=($page-1)*$rows;//开始截取位置
            $UserID=M('loans_applylist')->where(array("ID"=>$listID))->getField('UserID');
//			p($UserID);die;
            $Receivers=M('ss_duanxin')->where(array("UserID"=>$UserID))->getField('data');
            if($Receivers){
                $Receivers=json_decode($Receivers,1);
//          	P($Receivers);die;
                $data=$Receivers;
//			   p($data);

                //数据分页
                $array='';
                $array=array_slice($data,$start,$rows);
                $result=array();
                if($array){
                    foreach ($array as $val){
                        $result['rows'][]=$val;
                    }
                    $result['total']=count($data);
                }
                $this->ajaxReturn($result);
            }
        }
    }

    /**
     * 借款申请
     */
    public function ApplyDetail(){
        $listID=I('get.listID');//借款申请id
        if(!empty($listID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $sort='UpdateTime Desc';

            $UID=M('loans_applylist')->where(array("ID"=>$listID))->getField('UserID');
            $where['UserID']=$UID;
            //查询的列名
            $col='ID,LoanNo,ApplyMoney,AdoptMoney,FJMoney,Interest,CoMoney,ApplyDay,ApplyTime,LoanStatus,BackM,OrderSn,YyFkTime,SqAdminID,LoanType,Status,ServiceID,ShTime';
            //获取最原始的数据列表
            $query=new XBCommon\XBQuery();
            $array=$query->GetDataList(self::T_TABLE,$where,$page,$rows,$sort,$col);
            $LoanStatusArr = array(0=>"申请中",1=>"放款中",2=>"已放款",3=>"已完成",4=>"已取消",5=>"已拒绝",6=>"等待银行打款",7=>"打款失败,处理中");
            $StatusArr = array(0=>'待审核',1=>'审核成功',2=>'审核失败');
            $LoanTypeArr = array(0=>'普通',1=>'续借',2=>'分期');
            //如果查询结果有些数据不需要输出，或者需要特殊处理，则进行重组后输出
            $result=array();
            if($array['rows']){
                foreach ($array['rows'] as $val){
                    $val['SqAdminID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['SqAdminID']),'TrueName');
                    $val['ServiceID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['ServiceID']),'TrueName');
                    $val['LoanStatus']=$LoanStatusArr[$val['LoanStatus']];
                    $val['Status']=$StatusArr[$val['Status']];
                    $val['LoanType']=$LoanTypeArr[$val['LoanType']];
                    $result['rows'][]=$val;
                }
                $result['total']=$array['total'];
            }
            $this->ajaxReturn($result);
        }
    }
    /**
     * 还款记录
     */
    public function RepayDetail(){
        $listID=I('get.listID');//借款申请id
        if(!empty($listID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $sort='UpdateTime Desc';

            $UID=M('loans_applylist')->where(array("ID"=>$listID))->getField('UserID');
            $where['UserID']=$UID;
            //查询的列名
            $col='ID,LoanNo,TotalMoney,HkTime,CostPayable,RatePayable,SeviceCostPayable,FinePayable,Accounts,TradeNo,TradeRemark,PayType,PayStatus,AdminID,ShTime,Status';
            //获取最原始的数据列表
            $query=new XBCommon\XBQuery();
            $array=$query->GetDataList(self::T_HKLIST,$where,$page,$rows,$sort,$col);
            $PayTypeArr = array(0=>"未付款",1=>"支付宝",2=>"微信",3=>"银联",4=>"代付");
            $PayStatusArr = array(0=>'待支付',1=>'已支付');
            $StatusArr = array(0=>'待审核',1=>'审核通过',2=>'审核未通过');
            //如果查询结果有些数据不需要输出，或者需要特殊处理，则进行重组后输出
            $result=array();
            if($array['rows']){
                foreach ($array['rows'] as $val){
                    $val['AdminID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['AdminID']),'UserName');
                    $val['PayType']=$PayTypeArr[$val['PayType']];
                    $val['Status']=$StatusArr[$val['Status']];
                    $val['PayStatus']=$PayStatusArr[$val['PayStatus']];
                    $result['rows'][]=$val;
                }
                $result['total']=$array['total'];
            }
            $this->ajaxReturn($result);
        }
    }
    /**
     * 二维数组根据字段进行排序
     * @params array $array 需要排序的数组
     * @params string $field 排序的字段
     * @params string $sort 排序顺序标志 SORT_DESC 降序；SORT_ASC 升序
     */
    public function arraySequence($array, $field, $sort = 'SORT_DESC'){
        $arrSort = array();
        foreach ($array as $uniqid => $row) {
            foreach ($row as $key => $value) {
                $arrSort[$key][$uniqid] = $value;
            }
        }
        array_multisort($arrSort[$field], constant($sort), $array);
        return $array;
    }


}