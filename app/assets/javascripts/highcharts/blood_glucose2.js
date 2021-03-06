/**
 * Created by git on 14-5-8.
 */

// Apply the theme
//    var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
//    var blood_data=[[1274457600000, 1200], [1274544000000, 1300],[1274630400000, 1250],[1274803200000,1350]]
//    var blood_data=[[Date.parse("2013-01-01"), 1200], [Date.parse("2013-01-01"), 1300],[Date.parse("2013-01-03"), 1250],[Date.parse("2013-01-04"),1350],[Date.parse("2013-01-05"),1350],[Date.parse("2013-01-06"),1359],[Date.parse("2013-04-07"),1389]]
var glucosechart2;
var glucoseChart1Option2 = {
    chart: {
        type: 'area',
        renderTo: 'blood_container3',  //画到id为blood_container的div容器里
        spacingTop: 5,
        spacingLeft:20

    },
    legend: {
        enabled: false
    },
    plotOptions: {
        series: {
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#2aafa8',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',
            fillOpacity: 0.5,
            lineColor: '#2aafa8',
            lineWidth: 1

        }
    },
    rangeSelector: {
        stroke:'#cdcdcd',
        'stroke-width':1,
        enabled: true,
        buttonTheme: { // styles for the buttons
            fill: 'none',
            stroke: '#cdcdcd',
            'stroke-width':1,
            r:0,
            style: {
                color: '#49b9b4',
                fontWeight: 'bold'
            },
            states: {
                hover: {
                    stroke: '#cdcdcd',
                    fill: '#49b9b4',
                    style: {
                        color: 'white'
                    }
                },
                select: {
                    fill: '#49b9b4',
                    style: {
                        color: 'white'
                    }
                }
            }
        },

        buttons: [{
            type: 'week',
            count: 1,
            text: '1周'
        }, {
            type: 'week',
            count: 2,
            text: '2周'
        },
            {
                type: 'month',
                count: 1,
                text: '1月'
            }, {
                type: 'month',
                count: 3,
                text: '3月'
            }, {
                type: 'month',
                count: 6,
                text: '6月'
            },
            {
                type: 'year',
                count: 1,
                text: '1年'
            }, {
                type: 'all',
                text: '全部'
            }]
    },
    navigator: {
        outlineColor: '#cdcdcd',
        outlineWidth: 1 ,
        margin:20,
//        adaptToUpdatedData: false,//动态获取数据必须配置的选项
        series: {
            color: '#dceef6',
            fillOpacity: 1,
            lineColor:'#81c1e0'
        }
    },
    scrollbar: {
        barBorderColor:'#b7b9bf',
        buttonBorderColor:'#b7b9bf',
        barBackgroundColor: '#efefef'
    },
    credits: {
        enabled: false
    },
    navigation: {
        buttonOptions: {
            verticalAlign: 'top',
            y: -30

        }
    } ,
    title: {
        text: ''

    },
    subtitle: {
        text: ''
    },
    xAxis: {
        gridLineColor: '#cdcdcd',
        type: 'date',
        /*events:{
            afterSetExtremes:afterSetExtremes ////动态获取数据
        },*/
        dateTimeLabelFormats: {
            second: '%H:%M:%S',
            minute: '%e. %b %H:%M',
            hour: '%b/%e %H:%M',
            day: '%e/%b',
            week: '%e. %b',
            month: '%e. %b',
            year: '%Y'
        },
        labels: {
            formatter: function() {
                return  Highcharts.dateFormat('%m-%d', this.value);
            }
        }



    },
    yAxis: {
        gridLineColor: '#cdcdcd',
        lineColor: '#cdcdcd',
        lineWidth: 1,
        title: {
            text: '',
            style: {
                color: '#707070'
            }
        },
        showFirstLabel:true,
        min: 0


    },
    tooltip: {
        formatter: function () {
            var s = '<b>'+ Highcharts.dateFormat('%Y/%m/%d/%H:%M', this.x) +'</b>';
            $.each(this.points, function(i, point) {
                s += '<br/>血糖:'+ point.y +'mmol/L';
            });
            return s;
        },
        crosshairs: {
            dashStyle: 'solid',
            color:'#1292cb'
        }


    },
    series: [

        {
            name: '血糖',
            type:'line',
            data: [],
            events:{
                click:function(e){
                    $('#blood_glucose_modal2_update').modal('show');
                    $('#blood_glucose_id_update2').val(e.point.id);
                    $('#measure_value_g_update').val(e.point.y);
                    var unix=e.point.category;
                    var nowDate= new Date(unix);
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    $('#measure_date_glucose2_update').val(nowDate);
                }
            }



        }
    ]
};

//异步加载
function afterSetExtremes(e){
    var glucosechart221 = $("#blood_container3").highcharts();
    glucosechart221.showLoading('正在加载...');
    var startTime=Math.round(e.min);
     var endTime=Math.round(e.max);
    $.getJSON('/blood_glucose/all_glucose_data?start_time='+startTime+'&end_time='+endTime, function(data) {
        glucosechart221.series[0].setData(data);
        glucosechart221.hideLoading();
    });



}
$(document).ready(function () {
    glucosechart2 = new Highcharts.StockChart(glucoseChart1Option2)
    document.getElementById('blood_container3').style.display='none';
    document.getElementById('blood_container4').style.display='';
    $.ajax({
        type:'get',
        url:'/blood_glucose/all_glucose_data',
        success:function(data){
            if(data.length==0){
                $('#blood_container4').html("暂无数据")
            }else{
                document.getElementById('blood_container4').style.display='none';
                document.getElementById('blood_container3').style.display="";
                glucosechart2.series[0].setData(data);
            }
        }
    })


    //时间控件
    var nowDate = new Date();
    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
    $('#measure_date_glucose2').datetimepicker({
        lang:'ch',
        value: nowDate,
        timepicker:true,
        customformat:'Y-m-d H:m'
    });

//    血糖添加后的ajax响应
    function glucoseResponse2(responseText, statusText, xhr, $form) {
        $('#blood_glucose_modal2').modal('hide');
        $.ajax({
            type:'get',
            url:'/blood_glucose/all_glucose_data',
            success:function(data){
                document.getElementById('blood_container4').style.display='none';
                document.getElementById('blood_container3').style.display="";
                glucosechart2.series[0].setData(data);
            }
        })
    }
    ;
    //    血糖修改后的ajax响应
    function glucoseUpdateResponse2(responseText, statusText, xhr, $form) {
        $('#blood_glucose_modal2_update').modal('hide');
        $.ajax({
            type:'get',
            url:'/blood_glucose/all_glucose_data',
            success:function(data){
                document.getElementById('blood_container4').style.display='none';
                document.getElementById('blood_container3').style.display="";
                glucosechart2.series[0].setData(data);
            }
        })
    }
    ;
    // ajax 血糖添加form 提交
    $('#blood_glucose_submit2').click(function(){
        var options={
            url:'/blood_glucose/create',
            type:'post',
            data: $('#blood_glucose_form2').serialize(),
            success: glucoseResponse2

        };
        $.ajax(options);
        return false;
    });

    // ajax 血糖修改form 提交
    $('#blood_glucose_submit2_update').click(function(){
        var options={
            url:'/blood_glucose/update',
            type:'post',
            data: $('#blood_glucose_form2_update').serialize(),
            success: glucoseUpdateResponse2

        };
        $.ajax(options);
        return false;
    });
})