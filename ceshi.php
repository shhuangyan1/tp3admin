<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/12/9
 * Time: 11:21
 */

function encrypt_pkcs7($data,$key,$iv){
    //补码处理
    $blocksize = mcrypt_get_block_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
    $len = strlen($data);
    $pad = $blocksize - ($len % $blocksize);
    $data .= str_repeat(chr($pad), $pad);
    //开始加密
    $encrypted=mcrypt_encrypt(MCRYPT_RIJNDAEL_128,$key,$data,MCRYPT_MODE_CBC,$iv);
    return base64_encode($encrypted);
}

/*
 * @功能说明:AES CBC模式PKCS7 128位解密算法
 * @param $data 要解密的数据
 * @param $key 随机私有密钥
 * @param $iv 随机向量
 * @return string
 */
function decrypt_pkcs7($data,$key,$iv){
    $encryptedData=base64_decode($data);
    $decrypted=mcrypt_decrypt(MCRYPT_RIJNDAEL_128,$key,$encryptedData,MCRYPT_MODE_CBC,$iv);

    //php的pkcs7去码处理
    $length = strlen($decrypted);
    $unpadding = ord($decrypted[$length - 1]);
    return substr($decrypted, 0, $length - $unpadding);
}

echo encrypt_pkcs7('你好','KEYD444169B397BD77B7F01192798319','IV5682D5DB7B0EAF');


echo decrypt_pkcs7('LSo+gDHlPUigDtSd7X7c7w==','KEYD444169B397BD77B7F01192798319','IV5682D5DB7B0EAF');

