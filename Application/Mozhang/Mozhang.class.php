<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/12/21 0021
 * Time: 19:12
 */
namespace Mozhang;

class Mozhang
{
    public function getMoZhangContent( $name ,$idcard ,$mobile ,$qq_number=null )
    {
        $apiKey = M('sys_inteparameter')->where(['ParaName' => 'mx_appId'])->getField('ParaValue');//商户号
        $app_id = $apiKey;
        $method = "moxie.api.risk.magicwand2";
        $format = "JSON";
        $sign_type = "RSA";
        $version = "1.0";
        $timestamp = $this->getMillionSeconds();
        $biz_content = '{"name":"'.$name.'","idcard":"'.$idcard.'","mobile":"'.$mobile.'"}';
        $paramsStr = "app_id={$app_id}&biz_content={$biz_content}&format={$format}&method={$method}&sign_type={$sign_type}&timestamp={$timestamp}&version={$version}";

        //rsa私钥字符串
        $secret = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDNdwOq8XsuYOxkE7pRea+gJW233L7SXpgjJGpWN3zfId6ENaiNwOVlkU90QXe80zUZCYts62k5mFl/0DcvQVTd5HL55DQDCJjmGLudFnuyVqOCaCw9ExZRXrcT0bOmSohfbwNajwhhwTtpfYqEMKNDRAKabDp9Ly2AU5Gv9VPBNtpNjlsADqlOVyL6W070mFGOQXVGILUwyWCmTZyybnaF5X6+PR078Xxv1bEDJ7OFaZy3FXm277pxsENkdTpE5UX0OodZfRn0kJoKhfzj7IljjdpAq7Nk7941b5w5l/Dda1dAqu5A8LUVgUn6Z+dl6BClhXA9CaDF5YAY/FwwXvJzAgMBAAECggEAElCzoP9Zra6yI9GmYDDquOndN/CTigkooqlSWVEk7ncEcOCfn9M8H6uuW3yigdCKAStapGDvxlSQVdZntOyr9gOxRBlVkZeomYpG3x/r8t/KP4uttdwHt0UsKLYev4oRUgCBWgc6BgzFkQfB2zrCsvJTERToudQEyFWqvPavep+SGcUdQEGd7pw8dXhE6ClpWuhdtNiZrz/x2ljrcabcKJOcqtvpPiqow9nwSTzrLIBWTUJYyM8tJA0NlI6Q8NBIHKnjMb5mUxuTr6HyVdoIoWI5+E7j73d4bP3CmvT1Gaph9X5ZngZ9hiXvKaLorsrO6OQc30WrSaUiPRNC9e0kYQKBgQD5cgsAt4xmHa0BKVUJ9TWBbPqxQk6Kb0hxj3Bxy2wt881fuulGdaBymr7zAcPIjxl6C0OR6Po2oPT5oSLMqI+4JjiSYSsf75LUXuigJGapdbyGq0qJhLA+t55pbgtgCsvzcnQ+ew7iEtyceImgm9YyYIowapJvOxp4ITLSHExnSwKBgQDS3SACq2rxD3Dxc5EqEqcxv5GVmX+sYkD+w6iXjW0gXjh+bwNhPpCJl0VcfzC3oTweOBrooVn0NIvj8OOVg724AaDbTqokBW8OtcwTk5k46Qwpfgd+9b8lTKRucoZXNxUFVW4z1POimrl6m0f1NV1tk3aSJOmKcL7ENkwfitJgeQKBgGse/nqgWDrCI7mL9mkAVKnwEvhscS4h/ApIfxFfOmXBfUDPE76eZPjSW44gA+PtEBPJIotWcZ1kIc/R0w/wk0eRolm6QLrGN1fcKiobd7ruRLfQd4H26XkFgZHlIB1uhYdWb3Ulg46yausHGJNQWPvpWW7RVXFPAF72Ysy4OldhAoGAb71gHioKZK3jEwBD18DEutciZd1Oy+HRQXAbohv+zR1A4LchWmHWJCN2TRrVjSmy+uyOTeJbEc7aprLbVzrVyXGLdUvNW4NJo8jw2RrpIkBVApPXkw7U+QYRSLoFuKfmysnHuU3KwcsuKOuqiSV7Wfq/5ZgL7iHq5X1Ef56H9zkCgYANqMzNwUXqcF5+Zw/oVb+SirdfoaJXC9aWshtd/8SMBwtGQqlnhK5/8hLTrjM8720rCP9G+65WpZ9mCw18HKrp7wd3b6eJT4Qla8keac+cVEiLUhExs91DkES3BvsIzvP3NvCs4tPUKB0E0joRtZYT0l20Ws2rm59Jym17kPcPQA==";
        //获取签名
        $sign = $this->getSign($paramsStr,$secret);

        $url = 'https://api.51datakey.com/risk-gateway/api/gateway?'.$paramsStr."&sign=".$sign;
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_HTTPGET, true);
        $content = curl_exec($curl);

        if(curl_errno($curl))
        {
            $content =  curl_error($curl);
        }
        curl_close($curl);
        $val = json_decode($content,true);
        $value = $val['data'];
        $value = json_encode($value);
        return $value;
    }

    /**
     * 获取SHA1签名
     */
    public function getSign($paramsStr,$secret)
    {
        $signature = "";
        $str = chunk_split( $secret, 64, "\n" );
        $key = "-----BEGIN RSA PRIVATE KEY-----\n$str-----END RSA PRIVATE KEY-----\n";
        openssl_sign( $paramsStr  ,$signature ,$key  );

        return base64_encode($signature);
    }

    /**
     * 获取毫秒级时间戳
     * @return number
     */
    protected function getMillionSeconds()
    {
        list($msec, $sec) = explode(' ', microtime());
        $msectime =  (float)sprintf('%.0f', (floatval($msec) + floatval($sec)) * 1000);

        return $msectime ;
    }
}