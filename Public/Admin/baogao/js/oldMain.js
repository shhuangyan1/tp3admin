$(function(){
    $('#tabTagPage').find('.pageTab').click(function(index){
        var _index=$(this).index();
         $(this).siblings().removeClass('active');
         $(this).addClass('active');
         $('#pageTab').find('.pageTag').siblings().removeClass('activePage');
         $('#pageTab').find('.pageTag').eq(_index).addClass('activePage');
    });
});


function echartMap(obj){
     // 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById(obj.id));

    // 指定图表的配置项和数据

    var option = obj.option


    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

}


