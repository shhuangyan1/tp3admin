'use strict';

angular.module('cloudxWebApp')
.factory('publicMap', function () {
    //记得同步修改yhyend.html
    return {
        featuresSort :["6","7","18","21","23","24","2","13","17","8","0","10","5","11"],
        features : {
            "6":{
                name:"法院失信",
                text:"命中法院失信名单",
                level:0,
            },
            "7":{
                name:"网贷失信",
                text:"命中有盾网贷失信名单",
                level:0,
            },
            "18":{
                name:"活体攻击",
                text:"有盾云慧眼系统识别出该用户有过活体攻击行为",
                level:0,
            },
            "21":{
                name:"疑似欺诈团伙",
                text:"命中有盾疑似团伙欺诈名单库",
                level:0,
            },
            "23":{
                name:"网贷不良",
                text:"命中有盾网贷不良黑名单，逾期天数为30-90天",
                level:1,
            },
            "24":{
                name:"短期逾期",
                text:"命中有盾短期逾期黑名单，逾期天数为0-30天",
                level:3,
            },
            "2":{
                name:"羊毛党",
                text:"用户在多家互联网理财平台进行投资且投资额度较小",
                level:1,
            },
            "13":{
                name:"身份信息疑似泄漏",
                text:"用户信息存在被盗用的嫌疑",
                level:0,
            },
            "17":{
                name:"活体攻击设备",
                text:"该用户使用的某个设备曾有过活体攻击行为",
                level:0,
            },
            "8":{
                name:"关联过多",
                text:"身份证／设备号／手机号中的任意两个相互关联超过一定数量",
                level:1,
            },
            "0":{
                name:"多头借贷",
                text:"用户有在多家互联网借款平台有过实际借款行为",
                level:1,
            },
            "10":{
                name:"曾使用可疑设备",
                text:"有盾设备指纹技术识别到该用户曾经使用过的某个设备篡改过关键信息",
                level:1,
            },
            "5":{
                name:"作弊软件",
                text:"有盾设备指纹技术识别到该用户曾经使用过的某个设备中安装了作弊软件",
                level:1,
            },
            "11":{
                name:"安装极多借贷app",
                text:"有盾设备指纹技术识别到该用户曾经使用过的某个设备安装了极多借贷类APP",
                level:1,
            },
            // "1":{
            //     name:"投资达人",
            //     text:"用户在互联网理财平台的累积or单笔投资达到一定额度",
            //     level:3,
            // },
            // "3":{
            //     name:"旅游达人",
            //     text:"用户在互联网商旅行业中存在多次消费记录",
            //     level:3,
            // },
            // "4":{
            //     name:"游戏迷",
            //     text:"用户在游戏行业存在多次消费记录",
            //     level:3,
            // },
            // "9":{
            //     name:"主动履约用户",
            //     text:"用户在同一家小额贷款平台有过多次借款并还款的行为",
            //     level:3,
            // },
            // "12":{
            //     name:"高风险失信用户",
            //     text:"有盾模型判断该用户存在很高的坏账风险",
            //     level:0,
            // },
            // "14":{
            //     name:"阿里小号",
            //     text:"用户使用的某个手机号是通信小号",
            //     level:0,
            // },
            // "15":{
            //     name:"虚假手机号",
            //     text:"用户使用的某个手机号是虚假手机号",
            //     level:0,
            // },
            // "16":{
            //     name:"中风险失信用户",
            //     text:"有盾模型判断该用户存在较高的坏账风险",
            //     level:1,
            // },
            // "19":{
            //     name:"网贷失信设备",
            //     text:"曾有命中网贷失信黑名单的用户使用该设备进行身份认证",
            //     level:0,
            // },
            "20":{
                name:"黑中介团伙设备 ",
                text:"有盾发现的可疑黑中介团伙用户曾使用过的设备",
                level:-1,
            },
            // "21":{
            //     name:"黑中介团伙",
            //     text:"有盾通过社交网络分析的团伙挖掘关联方法发现的可疑黑中介团伙用户",
            //     level:-1,
            // },
            "22":{
                name:"可疑设备",
                text:"有盾设备指纹技术识别到该设备篡改过关键信息",
                level:-1,
            },
        },
        featuresType : {
            "1":{
                name:"互联网交易特征"
            },
            "2":{
                name:"关联特征"
            },
            "3":{
                name:"黑名单特征"
            },
            "4":{
                name:"资产特征"
            }
        }
    };
})
    .controller('UserOneInfoController', function($rootScope, $scope, $state, $timeout,$uibModal, $stateParams,$sce,ErrorTipModal,apiUserPage,previousState,publicMap) {
        $scope.root_localtest =$rootScope.localtest ;
        $scope.thisid=$stateParams.id;
        if(previousState=="userInfoOutShow"){
            $scope.isApi=true;
        }
        if(!$scope.thisid){
            $state.go("userOnePage");
            return;
        }
        $scope.dqmxhtmlTooltip = $sce.trustAsHtml('<div style="text-align: left;">模型说明：有盾贷前评估模型是有盾特别针对小额现金贷行业提供的一项服务。基于用户的全维度数据信息，结合有盾风控专家多年的行业经验，有盾人工智能团队通过机器学习的数据挖掘算法，综合评判用户的小贷逾期概率，及时预警潜在的逾期风险。'+
            '<div style="text-indent:2em;">有盾分值从0-100分，分值越高，逾期概率越大，商户可以根据自己的业务自行选择阈值进行判断。一般来说，阈值越高，坏用户的识别率就越高，同时好用户的误识率也会相应提高。'+
            '</div><div style="text-indent:2em;">同时，模型效果与样本训练息息相关，如果您希望进一步提升模型的效果，使其更加符合您的业务，您可以提供训练样本，有盾可以为您定制模型，具体事宜请咨询有盾商务</div></div>');
        $scope.glline_left=40;
        $scope.glline_right=90;
        $scope.risk_level=[40,55,80];
        $scope.gltmpList=[
            // {date:"2017-05-3",selftime:20,othertime:0},
            // {date:"2017-05-7",selftime:12,othertime:11},
            // {date:"2017-05-10",selftime:0,othertime:0},
            // {date:"2017-05-8",selftime:20,othertime:0},
            // {date:"2017-05-9",selftime:0,othertime:12},
            // {date:"2017-05-10",selftime:0,othertime:0},
            // {date:"2017-05-11",selftime:12,othertime:11},
        ];
        $scope.featurePaddingList={true:'1px',false:'8px'};
        $scope.featuresMap=publicMap.features;
        $scope.featuresSort=publicMap.featuresSort;
        $scope.featuresTypeMap=publicMap.featuresType;
        $scope.selectData=$stateParams.selectData;
        $scope.mapCount={};
        $scope.featureColorList = [ '#fd7065','#ffbf3b','#6dc7c2','#5bc3e1','#9e9e9e'];
        $scope.chartColorList = [ '#4694d9','#77d7e8','#25b97d'];
        $scope.chartColorList2 = [ '#53d0df','#ffc03a'];
        $scope.fzColorList = [ '#9e9e9e','#25b97d','#5bc3e1','#ffbf3b','#fd7065'];
        $scope.trueOrFalse=function(data){
            if(data===1||data==="1"){
                return "是";
            }else if(data===0||data==="0"){
                return "否";
            }else{
                return "";
            }
        }
        $scope.hasOrhasnot=function(data){
            if(data===1||data==="1"){
                return "有";
            }else{
                return "";
            }
        }
        $scope.init = function () {
            $scope.chart1 = echarts.init(document.getElementById('user_chart_show1'));
            $scope.chart2 = echarts.init(document.getElementById('user_chart_show2'));
            $scope.chart3 = echarts.init(document.getElementById('user_chart_show3'));
            $scope.chart_kedu = echarts.init(document.getElementById('user_chart_kedu'));
            $scope.chart_user = echarts.init(document.getElementById('user_chart_user'));
            $scope.chart_user.on('click', function (params) {
                console.log(params)
                if($("#user_chart_user canvas").css("cursor").indexOf("check1.png")>=0){
                    if(params.data.category=="身份证"&&params.data._is_main=="true"&&params.data._is_mark!="true"){
                        if(params.data._id_number){
                            apiUserPage.markpartneruser({
                                "id_number":params.data._id_number,
                                "is_mark":"1"
                            },function(data){
                                if(data.is_success=="true"){
                                    ErrorTipModal.show("标记成功");
                                    $("#user_chart_user canvas").css("cursor","");
                                    $scope.chart_user_option.series[0].data.map(function(a){
                                        if(a.value==params.data.value){
                                            a._is_mark="true";
                                            if(params.data._feature){
                                                a.symbol="image://content/images/icon/u_ID_CARD3.png";
                                            }else{
                                                a.symbol="image://content/images/icon/u_ID_CARD2.png";
                                            }
                                        }
                                    })
                                    $scope.chart_user.setOption($scope.chart_user_option);
                                }else{
                                    ErrorTipModal.show(data.msg||"标记失败");
                                }
                            });
                        }else{
                            ErrorTipModal.show("该用户数据错误");
                            $("#user_chart_user canvas").css("cursor","");
                        }
                    }else{
                        ErrorTipModal.show("只能标记当前用户");
                    }
                }else if($("#user_chart_user canvas").css("cursor").indexOf("check2.png")>=0){
                    if(params.data.category=="身份证"&&params.data._is_main=="true"&&params.data._is_mark=="true"){
                        if(params.data._id_number){
                            ErrorTipModal.show("取消标记成功");
                            $("#user_chart_user canvas").css("cursor","");
                            apiUserPage.markpartneruser({
                                "id_number":params.data._id_number,
                                "is_mark":"0"
                            },function(data){
                                if(data.is_success=="true"){
                                    $scope.chart_user_option.series[0].data.map(function(a){
                                        if(a.value==params.data.value){
                                            a._is_mark="false";
                                            if(params.data._feature){
                                                a.symbol="image://content/images/icon/u_ID_CARD1.png";
                                            }else{
                                                a.symbol="image://content/images/icon/u_ID_CARD.png";
                                            }
                                        }
                                    })
                                    $scope.chart_user.setOption($scope.chart_user_option);
                                }else{
                                    ErrorTipModal.show(data.msg||"取消标记失败");
                                }
                            });
                        }else{
                            ErrorTipModal.show("该用户数据错误");
                            $("#user_chart_user canvas").css("cursor","");
                        }
                    }else{
                        ErrorTipModal.show("只能取消标记当前用户");
                    }
                }else if(params.data.category=="身份证"&&params.data._is_main!="true"){
                    if(params.data._id_number){
                        var winRef = window.open("", "_blank");
                        apiUserPage.getIdByMapkey({id_number:params.data._id_number},function(data){
                            if(data.id){
                                winRef.location = "/#/user-one-info/"+data.id;
                            }else{
                                ErrorTipModal.show("非本商户用户无法查看该用户画像");
                                winRef.close();
                            }
                        },function(){
                            winRef.close();
                        });
                    }
                    // $uibModal.open({
                    //     animation: true,
                    //     backdrop: 'static',
                    //     templateUrl: 'MessageModal.html',
                    //     controller: 'MessageModalController',
                    //     resolve: {
                    //         serviceCode: function () {
                    //             return {
                    //                 callback:function(){window.open("/#/user-one-info/58da07d7b17a7c833abf4d95")},
                    //                 message:"是否在新窗口打开改用户画像维度？"
                    //             };
                    //         }
                    //     }
                    // });
                }
            });
            apiUserPage.risklevel({},function(data){
                if(data.risk_level&&data.risk_level.split(",").length==3){
                    $scope.risk_level=data.risk_level.split(",");
                }
                for(var i=0;i<$scope.risk_level.length;i++){
                    $scope.risk_level[i]=+$scope.risk_level[i];
                }
                $scope.select($scope.thisid);
            });
            $scope.getglwidth();
            $scope.getInfoMap($scope.thisid);
            if( $scope.root_localtest){
                $scope.select($scope.thisid);
            }
        }

        $scope.select = function (id) {
            function replaceGang(ent){
                for(var i in ent){
                    if(ent[i]=="-"){
                        ent[i]=""
                    }else if(!angular.isString(ent[i])){
                        replaceGang(ent[i])
                    }
                }
            }
            function isEmpty(ent){
                var list=["loanPlatformCount","lastLoanDate","repaymentPlatformNum","repaymentCountTimes","lastRepaymentDate"];
                for(var i=0;i<list.length;i++){
                    if(ent[list[i]]&&ent[list[i]]!="0"&&ent[list[i]]!="-"){
                        return false;
                    }
                }
                return true;
            }
            function _fillDate(data){
                replaceGang(data);
                $scope.data=data;
                for(var i in $scope.featuresMap){
                    $scope.featuresMap[i].show=false;
                    $scope.featuresMap[i].last_modified_time="";
                }
                if($scope.data.userDetail&&$scope.data.userDetail.user_features){
                    for(var i=0;i<$scope.data.userDetail.user_features.length;i++){
                        var user_fent=$scope.data.userDetail.user_features[i];
                        if($scope.featuresMap[user_fent.user_feature_type]){
                            $scope.featuresMap[user_fent.user_feature_type].show=true;
                            $scope.featuresMap[user_fent.user_feature_type].last_modified_time=user_fent.last_modified_time;
                        }
                    }
                    $scope.data.userDetail.user_features.sort(function(a,b){return a._level-b._level;})
                }

                $scope.featuresSortMap=$scope.featuresSort.map(function(a) {
                    return $scope.featuresMap[a];
                })
                if($scope.data.deviceDetail){
                    for(var i=0;i<$scope.data.deviceDetail.length;i++){
                        if($scope.data.deviceDetail[i].device_name){
                            $scope.data.deviceDetail[i].device_name=$scope.data.deviceDetail[i].device_name.replace(/\([^\)]*\)/g,"");
                        }
                    }
                }
                if($scope.data.installmentInfo){
                    for(var i=$scope.data.installmentInfo.length;i--;){
                        if(isEmpty($scope.data.installmentInfo[i])){
                            $scope.data.installmentInfo.splice(i,1);
                        }
                    }
                }
                if($scope.data.deviceDetail){
                    $scope.data.deviceDetail.sort(function(a,b){
                        return new Date(b.device_last_use_time||"1900-01-01")-new Date(a.device_last_use_time||"1900-01-01");
                    });
                }
                if($scope.data.cardDetail){
                    $scope.data.cardDetail.sort(function(a,b){
                        return new Date(b.lastUseTime||"1900-01-01")-new Date(a.lastUseTime||"1900-01-01");
                    });
                }
                if($scope.data.mobileDetail){
                    $scope.data.mobileDetail.sort(function(a,b){
                        return new Date(b.mobile_last_use_time||"1900-01-01")-new Date(a.mobile_last_use_time||"1900-01-01");
                    });
                }
                $scope.initChart($scope.data.userDetail,$scope.data.otherIndustryMap);
            }
            if( $scope.root_localtest){
                var __data__={"result":{"success":true,"message":"操作成功"},"data":{"deviceDetail":[{"device_name":"iPhone 6(A1549/A1586/A1589)","device_id":"97_80f1943a-854d-4e80-8494-5573df107649","device_last_use_time":"2017-04-26","deviceDetail":{"p":"","r":"0","c":"","i":"","n":"WiFi"},"id_link_device_count":"2","device_link_id_count":"1"},{"device_name":"samsung GT-I9508","device_id":"97_e687b141-4d82-4006-86e1-6643ad49430e","device_last_use_time":"2017-07-12","deviceDetail":{"p":"","cc":"0","r":"0","c":"","i":"","y":"0","it":"13","l":"2","n":"WiFi"},"id_link_device_count":"2","device_link_id_count":"0"}],"userDetail":{"user_features":[{"user_feature_type_desp":"多头借贷","type_name":"互联网交易特征","last_modified_time":"2017-07-17","user_feature_type":"0","type":"1"}],"last_modified_time":"2017-07-21 16:39:32","actual_platform_count":"21","loan_platform_count":"27","repaymentPlatformCount1M":"8","repayment_times_count":"48","repaymentPlatformCount3M":"16","repaymentPlatformCount6M":"16","score":"4","loan_last_time":"2017-07-11","loanPlatformCount3M":"17","names":"网纹,  测试,  吴文峰,吴文风","id_detail":{"birthday":"1992.06.01","province":"四川","gender":"男","city":"巴中"},"id_number_mask":"5137************77","name_credible":"吴文峰","loanPlatformCount6M":"20","actualLoanPlatformCount6M":"16","name":"  吴文峰","actualLoanPlatformCount1M":"8","actualLoanPlatformCount3M":"16","repayment_last_time":"2017-07","repayment_platform_count":"21","loanPlatformCount1M":"9","risk_evaluation":"较低风险"},"cardCount":"1","userHaveCardCount":"1","mobileCount":"1","installmentInfo":[{"actualLoanPlatform":"20","loanPlatformCount":"24","repaymentCountTimes":"47","name":"小额现金贷","repaymentPlatformNum":"20","lastRepaymentDate":"2017-07","lastLoanDate":"2017-04-26"},{"actualLoanPlatform":"1","loanPlatformCount":"1","repaymentCountTimes":"1","name":"分期行业","repaymentPlatformNum":"1","lastRepaymentDate":"2016-09","lastLoanDate":"-"},{"loanPlatformCount":"0","name":"大学生分期","lastLoanDate":"-"},{"loanPlatformCount":"1","name":"电商分期","lastLoanDate":"2017-04-27"},{"loanPlatformCount":"0","name":"旅游分期","lastLoanDate":"-"},{"loanPlatformCount":"1","name":"教育分期","lastLoanDate":"2017-07-11"},{"loanPlatformCount":"0","name":"汽车分期","lastLoanDate":"-"},{"loanPlatformCount":"0","name":"租房分期","lastLoanDate":"-"},{"loanPlatformCount":"0","name":"农业消金","lastLoanDate":"-"},{"loanPlatformCount":"0","name":"医美分期","lastLoanDate":"-"}]}}
                _fillDate(__data__.data);
                return;
            }
            if($scope.saveWaitFlag){return;}
            $scope.saveWaitFlag=true;
            apiUserPage.getIdDetail({id:id},function(data){
                if(data){
                    _fillDate(data);
                }
                $scope.saveWaitFlag=false;
            },function () {
                $scope.saveWaitFlag=false;
            });
        }
        $scope.getInfoMap=function(id){
            // if( $scope.root_localtest){
            //     $scope.initUser(__data__.data);
            //     $scope.isHasMap=true;
            //     return;
            // }
            apiUserPage.getIdDetailMap({id:id},function(data){
                if(!data||!data.nodes||!data.nodes.length){
                    $scope.isHasMapLoaded="关联图谱生成失败";
                    $scope.hideMapLoaded();
                }else if(data.nodes.length==1){
                    $scope.isHasMapLoaded="该用户无图谱信息";
                    $scope.hideMapLoaded();
                }else if(data){
                    $scope.initUser(data);
                    $scope.isHasMap=true;
                }
            },function () {
                $scope.isHasMapLoaded="关联图谱生成失败";
                $scope.hideMapLoaded();
            });
        }
        $scope.hideMapLoaded=function(){
            if(typeof $scope.isHasMapLoadedHide==="undefined"){
                $scope.isHasMapLoadedHide="3";
            }
            $timeout(function() {
                if(+$scope.isHasMapLoadedHide>0){
                    $scope.isHasMapLoadedHide=$scope.isHasMapLoadedHide-1;
                    $scope.hideMapLoaded();
                }
            }, 1000);
        }
        $scope.getglwidth=function(){
            for(var i=$scope.gltmpList.length;i--;){
                if(!$scope.gltmpList[i].selftime&&!$scope.gltmpList[i].othertime){
                    $scope.gltmpList.splice(i,1);
                }
            }
            if($scope.gltmpList.length<=1){
                return;
            }
            $scope.gltmpList.sort(function(a,b){
                return new Date(a.date)-new Date(b.date);
            });
            if($scope.gltmpList.length>10){
                $scope.gltmpList.splice(1,$scope.gltmpList.length-10);
                $scope.glhide=true;
            }
            if($scope.gltmpList.length<7){
                $scope.glline_left=400-$scope.gltmpList.length*50;
                $scope.glline_right=450-$scope.gltmpList.length*50;
            }
            $timeout(function() {
                $scope.glwidth=~~(($(".oneinfo-gl-line").width()-40)/($scope.gltmpList.length-1));
            }, 10);
        }
        $scope.address_yan=function (str) {
            if(str&&str.length>10){
                return str.substr(0,6)
                    +"********************".substr(0,str.length-10)
                    +str.substr(str.length-4,4)
            }else{
                return str;
            }
        }
        $scope.initChart = function (userDetail,otherIndustryMap) {
            if(userDetail){
                var max = userDetail.loan_platform_count-userDetail.repayment_platform_count>0?userDetail.loan_platform_count:userDetail.repayment_platform_count;
                $scope.chart1.setOption({
                    grid: {top:"40",bottom:"40"},
                    legend: {
                        data:['申请借款','借款'],
                        right :40,
                        itemGap :60,
                    },
                    xAxis: [{type: 'category',data: ['总计','近6月', '近3月', '近1月']}],
                    yAxis: [{show: false,type: 'value',max:max}],
                    series: [{
                        name: '申请借款',
                        type: 'bar',
                        barGap:'0',
                        barWidth :30,
                        label: {normal: {show: true,position: 'top'}},
                        itemStyle: {normal: {color: $scope.chartColorList[0]}},
                        data: [
                            userDetail.loan_platform_count||0,
                            userDetail.loanPlatformCount6M||0,
                            userDetail.loanPlatformCount3M||0,
                            userDetail.loanPlatformCount1M||0
                        ]
                    },{
                        name: '借款',
                        type: 'bar',
                        barGap:'0',
                        barWidth :30,
                        label: {normal: {show: true,position: 'top'}},
                        itemStyle: {normal: {color: $scope.chartColorList[1]}},
                        data: [
                            userDetail.actual_platform_count||0,
                            userDetail.actualLoanPlatformCount6M||0,
                            userDetail.actualLoanPlatformCount3M||0,
                            userDetail.actualLoanPlatformCount1M||0
                        ]
                    }]
                });
                $scope.chart2.setOption({
                    grid: {top:"40",bottom:"40"},
                    legend: {
                        data:['还款'],
                        left :"0"
                    },
                    xAxis: [{type: 'category',data: ['总计','近6月', '近3月', '近1月']}],
                    yAxis: [{show: false,type: 'value',max:max}],
                    series: [{
                        name: '还款',
                        type: 'bar',
                        barWidth :30,
                        label: {normal: {show: true,position: 'top'}},
                        itemStyle: {normal: {color: $scope.chartColorList[2]}},
                        data: [
                            userDetail.repayment_platform_count||0,
                            userDetail.repaymentPlatformCount6M||0,
                            userDetail.repaymentPlatformCount3M||0,
                            userDetail.repaymentPlatformCount1M||0
                        ]
                    }]
                });
            }
            if(otherIndustryMap){
                var chartxData3=[],charty1Data3=[],charty2Data3=[];
                $scope.merchSignedNum_all=0;
                $scope.merchTransNum_all=0;
                var max=0;
                for(var i=0;i<otherIndustryMap.length;i++){
                    chartxData3.push(otherIndustryMap[i].name);
                    charty1Data3.push(otherIndustryMap[i].merchSignedNum);
                    charty2Data3.push(otherIndustryMap[i].merchTransNum);
                    $scope.merchSignedNum_all+=(+otherIndustryMap[i].merchSignedNum);
                    $scope.merchTransNum_all+=(+otherIndustryMap[i].merchTransNum);
                    max=otherIndustryMap[i].merchSignedNum-max>0?otherIndustryMap[i].merchSignedNum:max;
                    max=otherIndustryMap[i].merchTransNum-max>0?otherIndustryMap[i].merchTransNum:max;
                }
                $scope.chart3.setOption({
                    grid: {top:"40",bottom:"40",left:'5%',right:'5%'},
                    legend: {
                        data:['认证','交易'],
                        right :"5%",
                        top:"0",
                        itemGap :60
                    },
                    xAxis: [{type: 'category',data: chartxData3,
                            axisTick: {show:false},
                            axisLine: {lineStyle: {color: '#cddee1'}},
                            axisLabel: {textStyle: {color: '#343f51'}}
                        }],
                    yAxis: [{type: 'value',minInterval: 1 ,splitNumber:(max<5? max:'5'),max:max,
                            axisTick: {show:false},
                            axisLine: {lineStyle: {color: '#cddee1'}},
                            axisLabel: {textStyle: {color: '#343f51'}},
                            splitLine: {lineStyle: {color: "#e4ecf2"}}
                        }],
                    series: [{
                        name: '认证',
                        type: 'bar',
                        barGap:'0.5',
                        barWidth :10,
                        label: {normal: {show: true,position: 'top'}},
                        itemStyle: {normal: {color: $scope.chartColorList2[0],barBorderRadius: [5, 5, 0, 0]}},
                        data: charty1Data3
                    },{
                        name: '交易',
                        type: 'bar',
                        barGap:'0.5',
                        barWidth :10,
                        label: {normal: {show: true,position: 'top'}},
                        itemStyle: {normal: {color: $scope.chartColorList2[1],barBorderRadius: [5, 5, 0, 0]}},
                        data: charty2Data3
                    }]
                });
            }
            if(userDetail){
                if(!userDetail.score){
                    userDetail.score="0";
                }
                if(!userDetail.risk_evaluation){
                    userDetail.risk_evaluation="缺少足够信息来进行风险评估";
                }
                userDetail.risk_evaluation=userDetail.risk_evaluation.replace("信息","信息\n");

                var scoreColor;
                if(userDetail.score==0){
                    scoreColor=$scope.fzColorList[0];
                }else if(userDetail.score<$scope.risk_level[0]){
                    scoreColor=$scope.fzColorList[1];
                }else if(userDetail.score<$scope.risk_level[1]){
                    scoreColor=$scope.fzColorList[2];
                }else if(userDetail.score<$scope.risk_level[2]){
                    scoreColor=$scope.fzColorList[3];
                }else if(userDetail.score<=100){
                    scoreColor=$scope.fzColorList[4];
                }
                var scoreOption={
                    grid: {top:"0",bottom:"0",left:'0',right:'0'},
                    title: {
                        x: "center",
                        top: 10
                    },
                    tooltip: {
                        formatter: "{a} <br/>{b} : {c}%"
                    },
                    series: [{
                        name: '有盾贷前模型',
                        type: 'gauge',
                        // startAngle: 180,
                        // endAngle: 0,
                        min:0,
                        max:100,
                        splitNumber: 20,
                        axisLine: {
                            show: true,
                            lineStyle: {
                                width: 10,
                                shadowBlur: 0,
                                color: [
                                    [$scope.risk_level[0]/100, $scope.fzColorList[1]],
                                    [$scope.risk_level[1]/100, $scope.fzColorList[2]],
                                    [$scope.risk_level[2]/100, $scope.fzColorList[3]],
                                    [1, $scope.fzColorList[4]]
                                ]
                            }
                        },
                        axisTick: {
                            show: true,
                            splitNumber: 1
                        },
                        splitLine:{
                            show: false,
                        },
                        axisLabel: {
                            formatter: function(e) {
                                if(e==0||e==100||$scope.risk_level.indexOf(e)!=-1){
                                    return e;
                                }else{
                                    return "";
                                }
                            },
                            interval:20,
                            textStyle: {
                                fontSize: 10,
                                fontWeight: "",
                                color:$scope.fzColorList[0]
                            },
                            distance:-15
                        },
                        pointer: {
                            show: false,
                        },
                        title: {
                            textStyle: {
                                color: scoreColor
                            }
                        },
                        detail: {
                            formatter: '{value}',
                            offsetCenter: [0, -10],
                            textStyle: {
                                fontSize: 64,
                                color: scoreColor
                            },
                        },
                        data: [{
                            name: userDetail.risk_evaluation,
                            value: userDetail.score
                        }]
                    }]
                }
                if(userDetail.score==0){
                    scoreOption.series[0].axisLine.lineStyle.color=[[1,$scope.fzColorList[0]]];
                    scoreOption.series[0].detail.show=false;
                    scoreOption.series[0].title.offsetCenter=[0, "5%"];
                }
                $scope.chart_kedu.setOption(scoreOption);
            }
        }
        $scope.initUser = function (data){
            var blacklist=['有盾&本地黑名单','有盾黑名单', '本地黑名单', '其他'],
                typeMap={
                    ID_CARD:{name:"身份证",icon:"image://content/images/icon/u_ID_CARD.png",textStyle:{color:"#5F9CD3",fontSize:18}},
                    MOBILE:{name:"手机号",icon:"image://content/images/icon/u_MOBILE.png",textStyle:{color:"#FDBF2E",fontSize:18}},
                    DEVICE:{name:"设备",icon:"image://content/images/icon/u_DEVICE.png",textStyle:{color:"#F2844A",fontSize:18}},
                    BANK_CARD:{name:"银行卡",icon:"image://content/images/icon/u_BANK_CARD.png",textStyle:{color:"#73AC4D",fontSize:18}},
                },
                chart_data=[],
                chart_links=[],
                chart_idList=[],
                chart_linksMap={},
                maxSize=25;
            for(var i in data.graph_link_info){
                $scope.mapCount[i]=data.graph_link_info[i]+"";
            }
            data._nodes=[];
            for(var i = 0, l=data.nodes.length; i < l; i++) {
                for(var j = i + 1; j < l; j++) {
                    if (data.nodes[i].id === data.nodes[j].id) {j = ++i; }
                }
                data._nodes.push(data.nodes[i]);
            }
            data.nodes=data._nodes;
            delete data._nodes;
            function pushTag(array,num){
                num=(num||1)+1;
                if(!array||array.length==0){return;}
                var nextArray=[];
                var renextArray=[];
                for(var i=0;i<data.nodes.length;i++){
                    if(array.indexOf(data.nodes[i].id)>-1&&!data.nodes[i]._nodelev_){
                        data.nodes[i]._nodelev_=num;
                        if(chart_linksMap[data.nodes[i].id]){
                            nextArray=nextArray.concat( chart_linksMap[data.nodes[i].id]);
                        }
                    }
                }
                for(var i = 0, l=nextArray.length; i < l; i++) {
                    for(var j = i + 1; j < l; j++) {
                        if (nextArray[i] === nextArray[j]) {j = ++i; }
                    }
                    renextArray.push(nextArray[i]);
                }
                pushTag(renextArray,num);
            }
            var mainId="";
            for(var i=0;i<data.nodes.length;i++){
                if(data.nodes[i].is_main=="true"){
                    mainId=data.nodes[i].id;
                    data.nodes[i]._nodelev_=1;
                    break;
                }
            }
            if(!mainId){return;}

            for(var i=0;i<data.relationships.length;i++){
                if(!chart_linksMap[data.relationships[i].startNode]){
                    chart_linksMap[data.relationships[i].startNode]=[data.relationships[i].endNode];
                }else{
                    chart_linksMap[data.relationships[i].startNode].push(data.relationships[i].endNode)
                }
                if(!chart_linksMap[data.relationships[i].endNode]){
                    chart_linksMap[data.relationships[i].endNode]=[data.relationships[i].startNode];
                }else{
                    chart_linksMap[data.relationships[i].endNode].push(data.relationships[i].startNode)
                }
            }
            pushTag(chart_linksMap[mainId]);


            if(data.nodes.length>500){
                $scope.mapToMuch=true;
                for(var i=data.nodes.length;i--;){
                    if(!data.nodes[i]._nodelev_||data.nodes[i]._nodelev_>3){
                        data.nodes.splice(i,1);
                    }
                }
            }else{
                for(var i=data.nodes.length;i--;){
                    if(!data.nodes[i]._nodelev_){
                        data.nodes.splice(i,1);
                    }
                }
            }
            if(data.nodes.length<=10){
                maxSize=60;
            }else if(data.nodes.length<=20){
                maxSize=50;
            }else if(data.nodes.length<=40){
                maxSize=45;
            }else if(data.nodes.length<=80){
                maxSize=40;
            }else if(data.nodes.length<=160){
                maxSize=35;
            }else if(data.nodes.length<=320){
                maxSize=30;
            }
            for(var i=0;i<data.nodes.length;i++){
                if(data.nodes[i].labels[0]=="ANDROID_DEVICE"){
                    data.nodes[i].labels[0]="DEVICE";
                }
                chart_idList.push(data.nodes[i].id);
                var _properties="";
                for(var ent in data.nodes[i].properties){
                    _properties+=ent+":"+data.nodes[i].properties[ent];
                }
                data.nodes[i].is_main=data.nodes[i].is_main+"";
                var obj={
                    "name": data.nodes[i].id,//'('+_properties+')',
                    "symbolSize": maxSize*1.7*Math.pow(0.75,data.nodes[i]._nodelev_),//data.nodes[i].is_main=="true"?maxSize*2:
                    "draggable": "true",
                    "value": data.nodes[i].id,
                    "category": typeMap[data.nodes[i].labels[0]].name,
                    "symbol":typeMap[data.nodes[i].labels[0]].icon,
                    "_is_main":data.nodes[i].is_main,
                    "_name":data.nodes[i].name,
                    "_id_number":data.nodes[i].id_number,
                    "_id_number_mask":data.nodes[i].id_number_mask,
                    "_is_mark":data.nodes[i].is_mark,
                    "_feature":data.nodes[i].properties.FEATURE,
                }
                if(obj._feature&&obj.category=="设备"){
                    obj.symbol="image://content/images/icon/u_DEVICE1.png"
                }else if(obj._is_mark=="true"&&obj._feature&&obj.category=="身份证"){
                    obj.symbol="image://content/images/icon/u_ID_CARD3.png"
                }else if(obj._feature&&obj.category=="身份证"){
                    obj.symbol="image://content/images/icon/u_ID_CARD1.png"
                }else if(obj._is_mark=="true"&&obj.category=="身份证"){
                    obj.symbol="image://content/images/icon/u_ID_CARD2.png"
                }
                chart_data.push(obj);
                if(data.nodes[i].is_main=="true"){
                    $scope.mapMainNode=obj;
                }
            }
            for(var i=0;i<data.relationships.length;i++){
                if(chart_idList.indexOf(data.relationships[i].startNode)>-1&&chart_idList.indexOf(data.relationships[i].endNode)>-1){
                    chart_links.push({
                        "source": chart_idList.indexOf(data.relationships[i].startNode),
                        "target": chart_idList.indexOf(data.relationships[i].endNode),
                    });
                }
            }
            $scope.chart_user_option = {
                tooltip: {
                    formatter: function(params) {
                        if(params.data.category=="身份证"){
                            var returnStr=params.data._name||"";
                            if(params.data._id_number_mask){
                                returnStr+="，"+params.data._id_number_mask;
                            }
                            if(params.data._feature){
                                var _feature="";
                                var _needShow=["6","7","18","21"];
                                params.data._feature.split(",").map(function(a){
                                    if(_needShow.indexOf(a)>-1&&$scope.featuresMap[a]){
                                        _feature+=$scope.featuresMap[+a].name+"、";
                                    }
                                })
                                if(_feature){
                                    returnStr+="，"+_feature.substr(0,_feature.length-1);
                                }
                            }
                            if(params.data._is_mark=="true"){
                                returnStr+="，已标记";
                            }
                            if(returnStr[0]=="，"){
                                returnStr=returnStr.substr(1,returnStr.length-1);
                            }
                            if(params.data._name&&params.data._is_main!="true"){
                                returnStr+="</br><span style='font-size:12px;color:#12AFDC;margin-left:50px;'>（点击查看详情）</span>"
                            }
                            return returnStr;
                        }else if(params.data.category=="设备"){
                            var returnStr=params.data._name||"";
                            if(params.data._feature){
                                var _feature="";
                                var _needShow=["17","19","20","10"];
                                params.data._feature.split(",").map(function(a){
                                    if(_needShow.indexOf(a)>-1&&$scope.featuresMap[a]){
                                        _feature+=$scope.featuresMap[+a].name.replace("曾使用可疑设备","可疑设备")+"、";
                                    }
                                });
                                if(_feature){
                                    returnStr+="，"+_feature.substr(0,_feature.length-1);
                                }
                                if(returnStr[0]=="，"){
                                    returnStr=returnStr.substr(1,returnStr.length-1);
                                }
                            }
                            return returnStr;
                        }
                    }
                },
                animationEasingUpdate: 'quinticInOut',
                series: [{
                    name: '关联图谱',
                    type: 'graph',
                    layout: 'force',
                    data: chart_data,
                    links: chart_links,
                    categories: (function(){
                        var _list=[]
                        for(var ent in typeMap){
                            _list.push({
                                name:typeMap[ent].name,
                                //itemStyle
                                // itemStyle:{normal:typeMap[ent].textStyle}
                                symbol:typeMap[ent].iconp
                            });
                        }
                        return _list
                    })(),
                    focusNodeAdjacency: true,
                    roam: true,
                    label: {
                        normal: {show: false,position: 'top',textStyle:{color:"#333",fontSize:10}}
                    },
                    lineStyle: {
                        normal: {color: "#333",curveness: 0,type: "solid"}
                    },
                    force: {repulsion: Math.pow(~~(maxSize/12),4)}
                }]
            };
            $scope.chart_user.setOption($scope.chart_user_option);
        }
        $scope.chooseBlack=function(){
            if($scope.saveWaitFlag){return;}
            $scope.saveWaitFlag=true;
            var params={data:$scope.mapMainNode};
            if(params.data.category=="身份证"&&params.data._is_main=="true"&&params.data._is_mark!="true"){
                if(params.data._id_number){
                    apiUserPage.markpartneruser({
                        "id_number":params.data._id_number,
                        "is_mark":"1"
                    },function(data){
                        if(data.is_success=="true"){
                            ErrorTipModal.show("标记成功");
                            $scope.chart_user_option.series[0].data.map(function(a){
                                if(a.value==params.data.value){
                                    a._is_mark="true";
                                    if(params.data._feature){
                                        a.symbol="image://content/images/icon/u_ID_CARD3.png";
                                    }else{
                                        a.symbol="image://content/images/icon/u_ID_CARD2.png";
                                    }
                                }
                            })
                            $scope.chart_user.setOption($scope.chart_user_option);
                        }else{
                            ErrorTipModal.show(data.msg||"标记失败");
                        }
                        $scope.saveWaitFlag=false;
                    },function(){
                        $scope.saveWaitFlag=false;
                    });
                }else{
                    ErrorTipModal.show("标记失败");
                    $scope.saveWaitFlag=false;
                }
            }else{
                ErrorTipModal.show("标记失败");
                $scope.saveWaitFlag=false;
            }
        }
        $scope.delChooseBlack=function(){
            if($scope.saveWaitFlag){return;}
            $scope.saveWaitFlag=true;
            var params={data:$scope.mapMainNode};
            if(params.data.category=="身份证"&&params.data._is_main=="true"&&params.data._is_mark=="true"){
                if(params.data._id_number){
                    ErrorTipModal.show("取消标记成功");
                    apiUserPage.markpartneruser({
                        "id_number":params.data._id_number,
                        "is_mark":"0"
                    },function(data){
                        if(data.is_success=="true"){
                            $scope.chart_user_option.series[0].data.map(function(a){
                                if(a.value==params.data.value){
                                    a._is_mark="false";
                                    if(params.data._feature){
                                        a.symbol="image://content/images/icon/u_ID_CARD1.png";
                                    }else{
                                        a.symbol="image://content/images/icon/u_ID_CARD.png";
                                    }
                                }
                            })
                            $scope.chart_user.setOption($scope.chart_user_option);
                        }else{
                            ErrorTipModal.show(data.msg||"取消标记失败");
                        }
                        $scope.saveWaitFlag=false;
                    },function(){
                        $scope.saveWaitFlag=false;
                    });
                }else{
                    ErrorTipModal.show("取消标记失败");
                    $scope.saveWaitFlag=false;
                }
            }else{
                ErrorTipModal.show("取消标记失败");
                $scope.saveWaitFlag=false;
            }
        }
        $scope.init();
    })
