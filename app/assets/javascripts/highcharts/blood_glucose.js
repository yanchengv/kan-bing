/**
 * Created by git on 14-5-8.
 */

// Apply the theme
//    var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
//    var blood_data=[[1274457600000, 1200], [1274544000000, 1300],[1274630400000, 1250],[1274803200000,1350]]
//    var blood_data=[[Date.parse("2013-01-01"), 1200], [Date.parse("2013-01-01"), 1300],[Date.parse("2013-01-03"), 1250],[Date.parse("2013-01-04"),1350],[Date.parse("2013-01-05"),1350],[Date.parse("2013-01-06"),1359],[Date.parse("2013-04-07"),1389]]
 var glucosechart;
var glucoseChart1Option = {
    chart: {
        type: 'area',
        renderTo: 'blood_container',  //画到id为blood_container的div容器里
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
//            maxZoom: 30 * 24 * 3600000, // fourteen days
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
                    $('#blood_glucose_modal_update').modal('show');
                    $('#blood_glucose_id_update').val(e.point.id);
                    $('#measure_value_update').val(e.point.y);
                    var unix=e.point.category;
                    var nowDate= new Date(unix);
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    $('#measure_time_update').val(nowDate);
                }
            }



        }
    ]
};

$(document).ready(function () {
     glucosechart = new Highcharts.StockChart(glucoseChart1Option)
     document.getElementById('blood_container').style.display='none';
    document.getElementById('blood_container2').style.display='';
    $.ajax({
        type:'get',
        url:'/blood_glucose/all_glucose_data',
        success:function(data){
            if(data.length==0){
                $('#blood_container2').html("暂无数据")
            }else{
                document.getElementById('blood_container2').style.display='none';
                document.getElementById('blood_container').style.display="";
                glucosechart.series[0].setData(data);
            }
        }
    })



    //时间控件
    var nowDate = new Date();
    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
    $('#measure_time').datetimepicker({
        lang:'ch',
        value: nowDate,
        timepicker:true,
        customformat:'Y-m-d H:m'
    });
//    ajax 添加后的响应
    function glucoseResponse(responseText, statusText, xhr, $form) {
        $('#blood_glucose_modal').modal('hide');
        $.ajax({
            type:'get',
            url:'/blood_glucose/all_glucose_data',
            success:function(data){
                document.getElementById('blood_container2').style.display='none';
                document.getElementById('blood_container').style.display="";
                glucosechart.series[0].setData(data);
                glucosechart2.series[0].setData(data);
            }
        })
    }
    ;


    //    ajax 修改后的响应
    function glucoseUpdateResponse(responseText, statusText, xhr, $form) {
        $('#blood_glucose_modal_update').modal('hide');
        $.ajax({
            type:'get',
            url:'/blood_glucose/all_glucose_data',
            success:function(data){
                document.getElementById('blood_container2').style.display='none';
                document.getElementById('blood_container').style.display="";
                glucosechart.series[0].setData(data);
                glucosechart2.series[0].setData(data);
            }
        })
    }
    ;
    // 添加数据form ajax 提交
    $('#blood_glucose_submit').click(function(){
        var options={
            url:'/blood_glucose/create',
            type:'post',
            data: $('#blood_glucose_form').serialize(),
            success: glucoseResponse

        };
        $.ajax(options);
        return false;
    });

    // 修改数据form ajax 提交
    $('#blood_glucose_submit_update').click(function(){
        var options={
            url:'/blood_glucose/update',
            type:'post',
            data: $('#blood_glucose_form_update').serialize(),
            success: glucoseUpdateResponse

        };
        $.ajax(options);
        return false;
    });
})