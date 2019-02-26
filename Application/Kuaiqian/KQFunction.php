<?php
namespace Kuaiqian;

class KQFunction{

    //快钱公钥地址
    protected $pubkey_path = '';

    //商户PFX证书地址
    protected $pfx_path = '';

    //证书密码
    protected $key_password = '';

    public function __construct(){
        $this->pubkey_path = './kuaiqian/99bill.cert.rsa.20340630.cer';
        $this->pfx_path = './kuaiqian/99bill-rsa.pfx';
        $this->key_password = 'juxindai';
    }

    //私钥加密RSAwithSHA1
    public function crypto_seal_private($original_data){
        //        $pfx_file='file://'.$this->pfx_path;
        $pfx_file = $this->pfx_path;
        $pfx=file_get_contents($pfx_file);
        $certs=array();
        openssl_pkcs12_read($pfx,$certs,$this->key_password);
        $privkey=$certs['pkey'];
        openssl_sign($original_data,$signature,$privkey,OPENSSL_ALGO_SHA1);
        return base64_encode($signature);
    }

    //公钥加密OPENSSL_PKCS1_PADDING
    public function crypto_seal_pubilc($original_data){
        $pubkey_file=$this->pubkey_path;
//        $pubkey=file_get_contents("file://".$pubkey_file);
        $pubkey=file_get_contents($pubkey_file);
        openssl_public_encrypt($original_data,$signature,$pubkey,OPENSSL_PKCS1_PADDING);
        return base64_encode($signature);
    }

    //私钥解密OPENSSL_PKCS1_PADDING
    public function crypto_unseal_private($digitalEnvelope){
        //        $pfx_file='file://'.$this->pfx_path;
        $pfx_file=$this->pfx_path;
        $pfx=file_get_contents($pfx_file);
        $certs=array();
        openssl_pkcs12_read($pfx,$certs,$this->key_password);
        $privkey=$certs['pkey'];
        $digitalEnvelope = base64_decode($digitalEnvelope);
        openssl_private_decrypt($digitalEnvelope,$receivekey,$privkey,OPENSSL_PKCS1_PADDING);
        return $receivekey;
    }

    //AES加密
    public function encrypt_aes($encrypt,$key){
        $size = mcrypt_get_block_size(MCRYPT_RIJNDAEL_128,MCRYPT_MODE_CBC);
        $encrypt = $this->pkcs5Pad($encrypt,$size);
        $iv = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
        $passcrypt = mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $encrypt, MCRYPT_MODE_CBC,$iv);
        $encode = base64_encode($passcrypt);
        return $encode;
    }

    //AES解密
    public function decrypt_aes($str,$key) {
        $str =  base64_decode($str);
        $iv = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
        $or_data = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, $str, MCRYPT_MODE_CBC,$iv);
        $str = $this->pkcs5Unpad($or_data);
        return $str;
    }


    //pkcs5加密
    public function pkcs5Pad($text,$blocksize){
        $pad = $blocksize-(strlen($text)%$blocksize);
        return $text.str_repeat(chr($pad),$pad);
    }

    //pcks5解密
    public function pkcs5Unpad($text) {
        $pad = ord($text{strlen($text)-1});
        if ($pad>strlen($text))
            return false;
        if (strspn($text,chr($pad),strlen($text)-$pad)!=$pad)
            return false;
        return substr($text,0,-1*$pad);
    }

    //公钥验签
    public function crypto_unseal_pubilc($signedData,$receiveData){
        $MAC = base64_decode($signedData);
        $fp = fopen($this->pubkey_path, "r");
        $cert = fread($fp, 8192);
        fclose($fp);
        $pubkeyid = openssl_get_publickey($cert);
        $ok = openssl_verify($receiveData, $MAC, $pubkeyid);
        return $ok;
    }

    //gzip解密
    public function gzdecode($data)
    {
        $flags = ord(substr($data, 3, 1));
        $headerlen = 10;
        $extralen = 0;
        $filenamelen = 0;
        if ($flags & 4)
        {
            $extralen = unpack('v' ,substr($data, 10, 2));
            $extralen = $extralen[1];
            $headerlen += 2 + $extralen;
        }
        if ($flags & 8)
            $headerlen = strpos($data, chr(0), $headerlen) + 1;
        if ($flags & 16)
            $headerlen = strpos($data, chr(0), $headerlen) + 1;
        if ($flags & 2)
            $headerlen += 2;
        $unpacked = @gzinflate(substr($data, $headerlen));
        if ($unpacked === FALSE)
            $unpacked = $data;
        return $unpacked;
    }

    public function kq_curl($url,$str){
        $header[] = "Content-type: text/xml;charset=utf-8";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS,$str);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,false);
        $output = curl_exec($ch);
        return $output;
    }
}