<?php
/**
 * 快钱支付接口
 * Created by PhpStorm.
 * User: lcc
 * Date: 2018/12/12
 * Time: 09:49
 */

namespace Kuaiqian;

include "KQFunction.php";

class Kuaiqian
{
    /**
     * 快钱代付接口
     * 快钱付款到银行卡
     * @param $data
     * @return mixed
     */
    public function parkuaiqian($data)
    {
        $orderId = $data['orderId'];//订单号
        $bankName = $data['BankName'];//银行名称
        $bankAcctId = $data['BankNo'];//银行卡号
        $branchName = $data['OpenBankName'];//开户行名称
        $creditName = $data['cardHolderName'];//账户名称
        $mobile = $data['Mobile'];//手机号
        $amount = $data['amount'];//金额
        $memberCode = $data['memberCode'];//啥编号的
//        $memberCode = "10012138842";//啥编号的
        $province = "";//省份
        $city = "";//城市
        $memo = "";//备注
        $feeAction = "1";//付费方式 默认1

        $sendMessagePlaintext = null;
        $sendMessagePlaintext .= "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
        $sendMessagePlaintext .= "<pay2BankOrder>";
        $sendMessagePlaintext .= "<orderId>" . $orderId . "</orderId>";
        $sendMessagePlaintext .= "<bankName>" . $bankName . "</bankName>";
        $sendMessagePlaintext .= "<branchName>" . $branchName . "</branchName>";
        $sendMessagePlaintext .= "<creditName>" . $creditName . "</creditName>";
        $sendMessagePlaintext .= "<mobile>" . $mobile . "</mobile>";
        $sendMessagePlaintext .= "<bankAcctId>" . $bankAcctId . "</bankAcctId>";
        $sendMessagePlaintext .= "<amount>" . $amount . "</amount>";
        $sendMessagePlaintext .= "<province>" . $province . "</province>";
        $sendMessagePlaintext .= "<city>" . $city . "</city>";
        $sendMessagePlaintext .= "<remark>" . $memo . "</remark>";
        $sendMessagePlaintext .= "<feeAction>" . $feeAction . "</feeAction>";
        $sendMessagePlaintext .= "</pay2BankOrder>";

        $kqFunction = new KQFunction();
        $originalData = $sendMessagePlaintext;//原始报文
        $autokey = rand(10000000, 99999999) . rand(10000000, 99999999); //随机KEY
        $signeddata = $kqFunction->crypto_seal_private($originalData);//私钥加密（验签/OPENSSL_ALGO_SHA1）
        $digitalenvelope = $kqFunction->crypto_seal_pubilc($autokey);//公钥加密（数字信封/OPENSSL_PKCS1_PADDING）
        $encrypteddata = $kqFunction->encrypt_aes($originalData, $autokey);//数据加密（AES/CBC/PKCS5Padding）

        $sendMessageRequest = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<pay2BankRequest>
    <pay2bankHead>
        <version>1.0</version>
        <memberCode>' . $memberCode . '</memberCode>
    </pay2bankHead>
    <requestBody>
        <sealDataType>
            <originalData></originalData>
            <signedData>' . $signeddata . '</signedData>
            <encryptedData>' . $encrypteddata . '</encryptedData>
            <digitalEnvelope>' . $digitalenvelope . '</digitalEnvelope>
        </sealDataType>
    </requestBody>
</pay2BankRequest>';

        $header[] = "Content-type: text/xml;charset=utf-8";
//        $url = "https://sandbox.99bill.com/fo-pay/pay2bank/pay";
        $url = "https://www.99bill.com/fo-pay/pay2bank/pay";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $sendMessageRequest);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        $output = curl_exec($ch);

//        $dom = new DOMDocument();
//        $dom->loadXML($output);
//        $receive = array(
//            'errorCode' => $dom->getElementsByTagName('errorCode')->item(0)->nodeValue,//错误编号
//            'signedData' => $dom->getElementsByTagName('signedData')->item(0)->nodeValue,//验签
//            'encryptedData' => $dom->getElementsByTagName('encryptedData')->item(0)->nodeValue,//加密报文
//            'digitalEnvelope' => $dom->getElementsByTagName('digitalEnvelope')->item(0)->nodeValue//数字信封
//        );
        //解密响应报文
//        $receivekey = $kqFunction->crypto_unseal_private($receive['digitalEnvelope']);
//        $receiveData2 = $kqFunction->decrypt_aes($receive['encryptedData'], $receivekey);

        libxml_disable_entity_loader(true);//curl返回的数据.在页面中展示是不会显示xml标签的.会将标签变成实体字符.这一行代表的是禁止变成实体字符
        $xml = simplexml_load_string($output);
        $val = json_decode(json_encode($xml), true);

        $myfile = fopen("daifu.txt", "w") or die("Unable to open file!");
        fwrite($myfile,date('Y-m-d h:i:s',time()));
        fwrite($myfile,$originalData);
        fwrite($myfile,$output);
        fclose($myfile);

        curl_close($ch);
        if ($val['responseBody']['errorCode'] == '0000') {
            return ['status' => 1, 'msg' => '请求成功', 'data' => $val];
        } else {
            return ['status' => 0, 'msg' => $val['responseBody']['errorMsg'], 'data' => $val];
//            return ['status' => 0, 'msg' => $signeddata, 'data' => $val];
        }

    }


    /**
     * 快钱代收接口
     * 银行卡收款到快钱
     * @param $data
     * @return array
     */
    public function collectkuaiqian($data)
    {
        $version = "1.0";//版本号
        $interactiveStatus = "TR1";//消息状态
        $txnType = "PUR";//交易类型
        $merchantId = $data['merchantId'];//商户号
        $terminalId = $data['terminalId'];//终端编号
        $entryTime = date('YmdHis');//商户端交易时间 20180918173658
        $cardNo = $data['BankNo'];//卡号
        $amount = $data['amount'];//交易金额
        $externalRefNumber = $data['externalRefNumber'];//外部跟踪编号
        $cardHolderName = $data['cardHolderName'];//持卡人姓名
        $idType = "0";//证件类型 默认0
        $cardHolderId = $data['cardHolderId'];//持卡人身份证
        $kay = "phone";//扩展数据键
        $value = $data['Mobile'];//扩展数据值

        $reqXml = null;
        $reqXml .= "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
        $reqXml .= "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        $reqXml .= "<version>" . $version . "</version>";
        $reqXml .= "<TxnMsgContent>";
        $reqXml .= "<interactiveStatus>" . $interactiveStatus . "</interactiveStatus>";
        $reqXml .= "<txnType>" . $txnType . "</txnType>";
        $reqXml .= "<merchantId>" . $merchantId . "</merchantId>";
        $reqXml .= "<terminalId>" . $terminalId . "</terminalId>";
        $reqXml .= "<entryTime>" . $entryTime . "</entryTime>";
        $reqXml .= "<cardNo>" . $cardNo . "</cardNo>";
        $reqXml .= "<amount>" . $amount . "</amount>";
        $reqXml .= "<externalRefNumber>" . $externalRefNumber . "</externalRefNumber>";
        $reqXml .= "<cardHolderName>" . $cardHolderName . "</cardHolderName>";
        $reqXml .= "<idType>" . $idType . "</idType>";
        $reqXml .= "<cardHolderId>" . $cardHolderId . "</cardHolderId>";
        $reqXml .= "<extMap>";
        $reqXml .= "<extDate>";
        $reqXml .= "<key>" . $kay . "</key>";
        $reqXml .= "<value>" . $value . "</value>";
        $reqXml .= "</extDate>";
        $reqXml .= "</extMap>";
        $reqXml .= "</TxnMsgContent>";
        $reqXml .= "</MasMessage>";

        $url = "https://mas.99bill.com/cnp/purchase";
//        $url = "https://sandbox.99bill.com:9445/cnp/purchase";
//        $clientcert = "./kuaiqian/10411004511201290.pem";
        $clientcert = "./kuaiqian/81231006051070890.pem";
//        $challenge = "vpos123";
//        $merchantId = '104110045112012';//商户编号
//        $loginKey = 'vpos123';//登录密码

        $challenge = $data['loginKey'];
        $merchantId = $data['merchantId'];//商户编号
        $loginKey = $data['loginKey'];//登录密码
        $user_agent = "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)";
        $loginInfo = array(
            "Authorization: Basic " . base64_encode($merchantId . ":" . $loginKey)
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_USERAGENT, $user_agent);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_CAINFO, $clientcert);
        curl_setopt($ch, CURLOPT_SSLCERT, $clientcert);
        curl_setopt($ch, CURLOPT_SSLCERTPASSWD, $challenge);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $reqXml);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $loginInfo);
        $result = curl_exec($ch);

        if (curl_error($ch)) {
            curl_close($ch);
//            printf("Error %s: %s", curl_errno($ch), curl_error($ch));
            return ['status' => 0, 'msg' => '请求失败', 'data' => []];
        }

        libxml_disable_entity_loader(true);//curl返回的数据.在页面中展示是不会显示xml标签的.会将标签变成实体字符.这一行代表的是禁止变成实体字符
        $xml = simplexml_load_string($result);
        $val = json_decode(json_encode($xml), true);

        curl_close($ch);


        if ($val['ErrorMsgContent']['errorCode']) {
            return ['status' => 0, 'msg' => '支付失败', 'data' => []];
        }

        if ($val['TxnMsgContent']['responseCode'] == '00') {
            return ['status' => 1, 'msg' => $val['TxnMsgContent']['responseTextMessage'], 'data' => $val];
        } else {
            return ['status' => 0, 'msg' => $val['TxnMsgContent']['responseTextMessage'], 'data' => $val];
        }
    }


}