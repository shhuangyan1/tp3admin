<?php
/**
 * 功能说明: 淘宝认证控制器
 */
 namespace Admin\Controller\Renzen;
 
 use Admin\Controller\System\BaseController;
 use XBCommon;
 class TaobaoController extends BaseController{

     const T_TABLE='renzen_taobao';
     const T_ADMIN='sys_administrator';
     const T_MEMINFO='mem_info';
     const T_SHLIST='renzen_shlist';

     public function index(){
         $this->display();
     }


   //淘宝报告独立页面
     public function taobaobaogaotwo(){
     	$ID=I('request.ID');//认证表id
	    $data=M('renzen_taobao')->field('mistr,TaskID')->where(['ID'=>$ID])->find();//根据用户id去找tasdid
        if(!$data['TaskID']){
            $this->ajaxReturn(0,'暂不能查看报告!');
        }
		  $jumpurl='https://tenant.51datakey.com/taobao/report_data?data='.$data['mistr'];
		  $this->ajaxReturn(1,$jumpurl);
		
	}
     /**
      * 后台用户管理的列表数据获取
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
         // $UserID=I('post.UserID','');
         // if($UserID){
         //    $where['UserID']=$UserID;
         // }
         $MemAccount=I('post.MemAccount','');
         if($MemAccount){
            $MemIDS=M(self::T_MEMINFO)->where(array('MemAccount'=>array('like','%'.$MemAccount.'%')))->field('ID')->select();
            $ids=array_column($MemIDS, 'ID');
            //根据ID查询会员
            if($ids){
                $where['UserID']=array('in',$ids);
            }else{
                $where['UserID']=null;
            }
        }
         $Mobile=I('post.Mobile','');
         if($Mobile){
            $MemIDS=M(self::T_MEMINFO)->where(array('Mobile'=>array('like','%'.$Mobile.'%')))->field('ID')->select();
            $ids=array_column($MemIDS, 'ID');
            //根据ID查询会员
            if($ids){
                $where['UserID']=array('in',$ids);
            }else{
                $where['UserID']=null;
            }
        }
         $TrueName=I('post.TrueName','');
         if($TrueName){
            $MemIDS=M(self::T_MEMINFO)->where(array('TrueName'=>array('like','%'.$TrueName.'%')))->field('ID')->select();
            $ids=array_column($MemIDS, 'ID');
            //根据ID查询会员
            if($ids){
                $where['UserID']=array('in',$ids);
            }else{
                $where['UserID']=null;
            }
        }
         $Status=I('post.Status',-5,'int');
         if($Status!=-5){
            $where['Status']=$Status;
         }
         $where['IsDel']=0;
         //查询的数据表字段名
         $col='ID,UserID,RenzTime,Status';//默认全字段查询

         //获取主表的数据
         $query=new XBCommon\XBQuery;
         $array=$query->GetDataList(self::T_TABLE,$where,$page,$rows,$sort,$col);

         //重组数据返还给前段
         $result=array();
         if($array['rows']){
             foreach ($array['rows'] as $val) {
                 if($val['Status']=='0'){
                    $val['Status']='待审核';
                 }elseif($val['Status']=='1'){
                    $val['Status']='<span style="color:green;">已认证</span>';
                 }elseif($val['Status']=='2'){
                    $val['Status']='<span style="color:red;">认证失败</span>';
                 }
                 $meminfo='';
                 $meminfo=M(self::T_MEMINFO)->field('MemAccount,Mobile,TrueName')->find($val['UserID']);
                 $val['MemAccount']=$meminfo['MemAccount'];
                 $val['Mobile']=$meminfo['Mobile'];
                 $val['TrueName']=$meminfo['TrueName'];
                 $result['rows'][]=$val;
            }
            $result['total']=$array['total'];
         }
         $this->ajaxReturn($result);
     }
     //详情
     public function detail(){
        $ID=I('request.ID');
		$re=M('renzen_taobao')
                   ->field('Receivers,zhimafen')
                   ->where(array('ID'=>$ID))->find();
//	p($re);die;
		$res=json_decode($re['Receivers'],1);
		$res['ID']=$ID;
		$this->assign('infos',$res);//淘宝认证数据
		$this->assign('RenZenID',$ID);//认证id
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
		
		$this->assign('hbsxed',$hbsxed);//花呗授信额度
		
		
		
		
        $this->display('Renzen/Taobao/Detail');
//		p($res);
//	
 

     }
     //审核
     public function aduit(){
        $id=I('get.ID',0,'intval');
        $res=M(self::T_TABLE)->where(array("ID"=>$id))->find();
        $this->assign("res",$res);
        $this->display();
    }
    //审核信息提交处理
    public function aduitsave(){
        $ID=I('post.ID','');
        $Status=I('post.Status','0');
        $Intro=I('post.Intro','');
        if($Status=='0'){
            $this->ajaxReturn(1,'恭喜您，审核操作成功！');
        }
        if($Status=='2'){
            //2认证失败
            if(!$Intro){
                $this->ajaxReturn(0,'很抱歉，请填写认证失败的原因！');
            }
        }
        //修改xb_renzen_cards
        $updata=array(
            'Status'=>$Status,
            'OperatorID'=>$_SESSION['AdminInfo']['AdminID'],
            'UpdateTime'=>date("Y-m-d H:i:s"),
            );
        $rest=M(self::T_TABLE)->where(array('ID'=>$ID))->save($updata);
        if($rest){
            //记录下 xb_renzen_shlist 
            $UserID=M(self::T_TABLE)->where(array("ID"=>$ID))->getField('UserID');
            $datas=array(
                'RenZenID'=>$ID,
                'Codes'=>'taobao',
                'UserID'=>$UserID,
                'OperatorID'=>$_SESSION['AdminInfo']['AdminID'],
                'UpdateTime'=>date("Y-m-d H:i:s"),
                );
            if($Status=='1'){
                $datas['Descs']='淘宝认证通过';
            }elseif($Status=='2'){
                $datas['Descs']='淘宝认证失败';
            }
            if($Intro){
                $datas['Intro']=$Intro;
            }
            $rest2=M(self::T_SHLIST)->add($datas);
            if($rest2){
                $this->ajaxReturn(1,'恭喜您，审核操作成功！');
            }else{
                $this->ajaxReturn(0,'很抱歉，审核记录插入失败！');
            }
        }else{
            $this->ajaxReturn(0,'很抱歉，审核操作失败！');
        }
    }
    /**
     *审核记录
     */
    public function shenhelist(){
        $RenZenID=I('get.RenZenID');
        if(!empty($RenZenID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $sort='ID Desc';

            $where['RenZenID']=$RenZenID;
            $where['Codes']=array('eq','taobao');
            //查询的列名
            $col='';
            //获取最原始的数据列表
            $query=new XBCommon\XBQuery();
            $array=$query->GetDataList(self::T_SHLIST,$where,$page,$rows,$sort,$col);

            //如果查询结果有些数据不需要输出，或者需要特殊处理，则进行重组后输出
            $result=array();
            if($array['rows']){
                foreach ($array['rows'] as $val){
                    $val['Codes']='淘宝认证';
                    $val['UserID']=$query->GetValue(self::T_MEMINFO,array('ID'=>(int)$val['UserID']),'TrueName');
                    $val['OperatorID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['OperatorID']),'TrueName');
                    $result['rows'][]=$val;
                }
                $result['total']=$array['total'];
            }
            $this->ajaxReturn($result);
        }
    }
    //收货地址
    public function saddreslist(){
        $RenZenID=I('get.RenZenID');
        if(!empty($RenZenID)){
            //接收POST信息,拼接查询条件
            $page=I('post.page',1,'intval');
            $rows=I('post.rows',20,'intval');
            $start=($page-1)*$rows;//开始截取位置

            $Receivers=M('renzen_taobao')->where(array("ID"=>$RenZenID))->getField('Receivers');
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

 }