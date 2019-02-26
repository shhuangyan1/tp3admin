<?php
/**
 * 功能说明: 属性参数控制器
 */
namespace Admin\Controller\System;
 use XBCommon;
 class PropertyparamController extends BaseController{

     const T_TABLE='sys_propertyparam';
     const T_PROPERTYSET='sys_propertyset';
     const T_ADMIN='sys_administrator';

     public function index(){
         $this->display();
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
             $sort='Sort asc,ID desc';
         }

         //搜索条件
         $Name=I('post.Name');
         if($Name){
            $where['Name']=array('like','%'.$Name.'%');
         }
         $Status=I('post.Status',-5,'int');
         if($Status!=-5){
            $where['Status']=$Status;
         }
         $PropertyID=I('post.PropertyID');
         if($PropertyID){
            $where['PropertyID']=array('eq',$PropertyID);
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
                 if($val['Status']=='1'){
                    $val['Status']='<span style="color:green;">启用</span>';
                 }else{
                    $val['Status']='<span style="color:red;">禁用</span>';
                 }
                 $val['PropertyID']=$query->GetValue(self::T_PROPERTYSET,array('ID'=>(int)$val['PropertyID']),'Name');
                 $val['OperatorID']=$query->GetValue(self::T_ADMIN,array('ID'=>(int)$val['OperatorID']),'UserName');
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
         $this->assign(array(
            'ID'=>$id,
            ));
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
             array('Name','require','名称必须填写'),
             array('PropertyID','require','必须选择所属属性设置'),
         );

         //提交的表单数据进行规则验证,并创建数据对象
         $model=D(self::T_TABLE);
         $FormData=$model->validate($rules)->create();
         if(!$FormData){
              //验证不通过，返回保存失败的提示信息
             $this->ajaxReturn(0,$model->getError());
         }else{
             //创建新数组，用于存储保存的数据
             $data=array();

             //判断金额类型是否唯一
             $where['ID']=array('neq',$FormData['ID']);
             $where['Name']=$FormData['Name'];
             $where['IsDel']=0;
             $NameExist=$model->where($where)->find();
             if($NameExist){
                 $this->ajaxReturn(0,'名称已存在');
             }

             //保存数据
             $data=$FormData;
             $data['OperatorID']=$_SESSION['AdminInfo']['AdminID'];
             $data['UpdateTime']=date("Y-m-d H:i:s");
         }

         //更新或添加数据
         if($FormData['ID']>0){   //修改数据
             $saveResult=$model->where(array('ID'=>$FormData['ID']))->save($data);
             //返回保存的结果
             if($saveResult){
                 $this->ajaxReturn(1,'修改成功');
             }else{
                 $this->ajaxReturn(0,'修改失败');
             }
         }else{//添加数据(ID为空)

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
    //获取属性设置
    public function getdata(){
        $id=I('request.ID',0,'intval');
        $row[0]=['id'=>0,'text'=>'请选择'];
        if($id){
            $where=array('IsDel'=>0,);
        }else{
            $where=array('IsDel'=>0,'Status'=>1);
        }
        $Sjuserid=M(self::T_PROPERTYSET)->field('ID,Name')->where($where)->order('Sort asc,ID desc')->select();
        if($Sjuserid){
            foreach ($Sjuserid as $key=>$val){
                $row[$key+1]=['id'=>$val['ID'],'text'=>$val['Name']];
            }
        }
        $this->ajaxReturn($row);
    }

 }