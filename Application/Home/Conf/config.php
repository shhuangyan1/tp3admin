<?php
return array(
    //'配置项'=>'配置值'
    'CONTROLLER_LEVEL'      =>  1,
    'URL_CASE_INSENSITIVE' =>true,

    'URL_MODEL' => '2',
     'TMPL_PARSE_STRING' => array(
        '__PUBLIC__' => __ROOT__ . '/Public',
        '__JS__' => __ROOT__ . '/Public/Js',
        '__CSS__' => __ROOT__ . '/Public/Css',
        '__IMAGE__' => __ROOT__ . '/Public/Image',
        '__DATA__' => __ROOT__ . '/Data/'
    ),
);