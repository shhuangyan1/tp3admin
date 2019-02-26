<?php
/**
 * @功能说明:验证包名和版本号
 * @return string
 */

function get_login_info($key){

//  $para=get_json_data(1); //接收参数
    $AppInfo=\XBCommon\XBCache::GetCache($para['token']);

    if(!empty($AppInfo)){
        if(!empty($key)){
            return $AppInfo[$key];
        }else{
            return $AppInfo;
        }
    }else{
        return null;
    }
}

/**
 * @功能说明:处理成给定的json数据
 * @return $mark  为 0是返回用于一维  为1必须用于二维数组
 * @return $code  0-1   返回的状态描述
 * @return $msg  为返回内容
 */
function AjaxJson($mark = 0,$code = 0, $msg = 'success', $data = array(),$isaes = 0 ,$key='',$iv=''){
    $Array = array();
    if (is_array($code)) {
        $Array = $code;
    } else {
        if(!$msg){
            $msg = 'success';
        }
        if($isaes == 1){
            //if(!$key || !$iv){
                $key = get_login_info('KEY');
                $iv = get_login_info('IV');
            //}

            if($mark){
                $json = json_encode($data);
            }else{
                $json = json_encode($data,JSON_FORCE_OBJECT);
            }
            $data = encrypt_pkcs7($json,$key,$iv);
        }
        if($isaes == 1 && empty($data)){
            $data='abc';
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
    if($mark == 0){
        echo(json_encode($Array,JSON_FORCE_OBJECT ));
    }else{
        echo(json_encode($Array ));
    }
}

