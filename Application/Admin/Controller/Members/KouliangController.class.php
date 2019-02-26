<?php
/**
 * 功能说明: 扣量管理控制器
 */
namespace Admin\Controller\Members;
 
 use Admin\Controller\System\BaseController;
 use XBCommon;

 class KouliangController extends BaseController{

     const T_TABLE='tg_kouliang';
     const T_ADMIN='sys_administrator';
     const T_TGADMIN='tg_admin';

     public function index(){
         $this->display();
     }

     /**
      * 扣量列表数据获取
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
         $Tgadmin=I('post.Tgadmin',0,'int');
         if($Tgadmin!=0){
            $where['Tgadmin']=$Tgadmin;
         }
         $Status=I('post.Status',-5,'int');
         if($Status!=-5){
            $where['Status']=$Status;
         }
         $where['IsDel']=0;
         //查询的数据表字段名
         $col='';//默认全字段查询

         //获取主表的数据
         $query=new XBCommon\XBQuery;
         $array=$query->GetDataList(self::T_TABLE,$where,$page,$rows,$sort,$col);

         //重组数据返还给前段
         $result=array();
         if($array['rows']){
             foreach ($array['rows'] as $val) {
                 if($val['Kouliang']){
                    $val['Kouliang']=$val['Kouliang'].'%';
                 }
                 $val['AddTime']=date('Y-m-d H:i:s',$val['AddTime']);
                 $val['Tgadmin']=$query->GetValue(self::T_TGADMIN,array('ID'=>(int)$val['Tgadmin']),'Name');
                 $result['rows'][]=$val;
            }
            $result['total']=$array['total'];
         }
         $this->ajaxReturn($result);
     }


     /**
      * 编辑功能
      */
     public function Edit(){
         $id=I('request.ID',0,'intval');
         $this->assign('ID',$id);
         $this->display();
     }

     /**
      * 查询详细信息
      */
     public function shows(){
         $id=I('request.ID',0,'intval');
         if($id){
             $tabList=M(self::T_TABLE)->where(array('ID'=>$id))->find();
             $this->ajaxReturn($tabList);
         }else{
            $this->ajaxReturn(array('tabList'=>false,'message'=>'没有该记录'));
         }
     }

     /**
      *保存数据
      */
     public function Save(){

         if(!IS_POST){
             $this->ajaxReturn(0,'数据提交方式不对');
         }
         //验证规则
         $rules=array(
             array('Kouliang','require','扣量比例必须设置'),
         );

         //提交的表单数据进行规则验证,并创建数据对象
         $model=D(self::T_TABLE);
         $FormData=$model->validate($rules)->create();
         if(!$FormData){
              //验证不通过，返回保存失败的提示信息
             $this->ajaxReturn(0,$model->getError());
         }else{
             //保存数据
             $data=$FormData;
             $data['OperatorID']=$_SESSION['AdminInfo']['AdminID'];
             $data['AddTime']=time();
             $data['UpdateTime']=date("Y-m-d H:i:s");
         }

         if(!$FormData['Tgadmin']){
             $this->ajaxReturn(0,'请选择平台!');
         }

         //更新或添加数据
         if($FormData['ID']>0){  
             //修改数据
             $saveResult=$model->where(array('ID'=>$FormData['ID']))->save($data);
             //返回保存的结果
             if($saveResult){
                 $this->ajaxReturn(1,'修改成功');
             }else{
                 $this->ajaxReturn(0,'修改失败');
             }
         }else{//添加数据(ID为空)
             //创建新数组，用于存储保存的数据
             //$data=array();

             //判断此平台今天是否已经设置过了
             $where['Tgadmin']=array('eq',$FormData['Tgadmin']);
             $where['IsDel']=0;
             $where['from_unixtime(AddTime, "%Y-%m-%d")']=date('Y-m-d');
             $NameExist=$model->where($where)->find();
             if($NameExist){
                 $this->ajaxReturn(0,'此平台今天的扣量已经设置!');
             }
             $addResult=$model->add($data);
             if($addResult){
                $this->ajaxReturn(1,'添加成功');
             }else{
                 $this->ajaxReturn(1,'添加失败');
             }
         }
     }

     /**
      * 逻辑删除
      */
     public function Del(){

         //获取要删除的记录的id(单条或者多条)
         $ids=I('request.ID','','trim');
         $idArr=explode(',',$ids);

         $result=M(self::T_TABLE)->where(array('ID'=>array('in',$idArr)))->setField('IsDel',1);
         if($result){
             $this->ajaxReturn(1,'删除成功');
         }else{
             $this->ajaxReturn(0,'删除失败');
         }
     }
     /**
     * 获取平台
     */
    public function getCate(){
        $id=I('request.ID',0,'intval');
        $row[0]=['id'=>0,'text'=>'请选择'];
        if($id){
            $where=array('IsDel'=>0);
        }else{
            $where=array('IsDel'=>0,'Status'=>1);
        }
        $Sjuserid=M(self::T_TGADMIN)->field('ID,Name')->where($where)->select();
        if($Sjuserid){
            foreach ($Sjuserid as $key=>$val){
                $row[$key+1]=['id'=>$val['ID'],'text'=>$val['Name']];
            }
        }
        $this->ajaxReturn($row);
    }

 }