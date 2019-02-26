<?php

namespace Api\Controller\Home;
use Think\Controller;

class TController extends Controller
{

    public function t(){
        $t = common_token();
        echo $t;
    }


}