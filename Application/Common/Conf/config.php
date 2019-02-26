<?php
return array(
    /*数据库配置*/
	'DB_TYPE'   => 'mysql',         // 数据库类型我们是mysql，就对于的是mysql
	'DB_HOST'   => 'localhost',   // 服务器地址，就是我们配置好的php服务器地址，也可以使用localhost，47.96.88.25
	'DB_NAME'   => 'jd',      // 数据库名：mysq创建的要连接我们项目的数据库名称
	'DB_USER'   => 'root',           // 用户名：mysql数据库的名称
	'DB_PWD'    => 'root',                 //mysql数据库的 密码
	'DB_PORT'   => '3306',            // 端口服务端口一般选3306
	'DB_PREFIX' => 'xb_',            //  数据库表前缀
	'DB_CHARSET'=> 'utf8',         // 字符集
	'DB_PARAMS' => array(\PDO::ATTR_CASE => \PDO::CASE_NATURAL),
    'URL_CASE_INSENSITIVE' => false,
    'DB_RW_SEPARATE'        => false,     // 数据库读写是否分离 主从式有效

    
     /*邮箱配置*/
    'MAIL_SMTPAUTH' =>TRUE, //启用smtp认证
    'MAIL_CHARSET' =>'utf-8',//设置邮件编码
    'MAIL_ISHTML' =>TRUE, // 是否HTML格式邮件
    //配置文件信息
    'LOAD_EXT_CONFIG' => array('Help'=>'help'),
    
	
	
	
	   /* 日志设置 */
    'LOG_RECORD'            =>  false,   // 默认不记录日志
    'LOG_TYPE'              =>  'File', // 日志记录类型 默认为文件方式
    'LOG_LEVEL'             =>  'EMERG,ALERT,CRIT,ERR',// 允许记录的日志级别
    'LOG_FILE_SIZE'         =>  2097152,	// 日志文件大小限制
    'LOG_EXCEPTION_RECORD'  =>  false,    // 是否记录异常信息日志
);