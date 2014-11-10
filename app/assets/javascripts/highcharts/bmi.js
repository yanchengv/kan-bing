$(document).ready(function () {




//create bmi... 添加身体指数
    var nowCreateDate = new Date();
    nowCreateDate=nowCreateDate.getFullYear()+'/'+(nowCreateDate.getMonth()+1)+'/'+nowCreateDate.getDate()+'  '+nowCreateDate.getHours()+':'+nowCreateDate.getMinutes();
    //时间控件
    $('#bmi_date').datetimepicker({
        lang:'ch',
        value:nowCreateDate,
        timepicker:true,
        customformat:'Y-m-d H:m'
    });
    function bmiCreateResponse(responseText, statusText, xhr, $form) {
        $('#bmi_modal').modal('hide');
        $.ajax({
            type:'get',
            url:'/highcharts/bmi/all_bmi_data',
            success:function(data){
                document.getElementById('bmi_container2').style.display='none';
                document.getElementById('bmi_container').style.display="";
                bmiChart.series[0].setData(data);
                bmiChart.series[0].setData(data);
            }
        })

    }
    ;
    // ajax 提交
    $('#bmi_submit').click(function(){
        var options={
            url:'/highcharts/bmi/create',
            type:'post',
            data: $('#bmi_form').serialize(),
            success: bmiCreateResponse

        };
        $.ajax(options);
        return false;
    });

//    update bmi ...    修改身体指数
    var nowUpdateDate = new Date();
    nowUpdateDate=nowUpdateDate.getFullYear()+'/'+(nowUpdateDate.getMonth()+1)+'/'+nowUpdateDate.getDate()+'  '+nowUpdateDate.getHours()+':'+nowUpdateDate.getMinutes();
    //时间控件
    $('#bmi_update_date').datetimepicker({
        lang:'ch',
        value:nowUpdateDate,
        timepicker:true,
        customformat:'Y-m-d H:m'
    });
    function bmiUpdateResponse(responseText, statusText, xhr, $form) {
        $('#bmi_update_modal').modal('hide');
        $.ajax({
            type:'get',
            url:'/highcharts/bmi/all_bmi_data',
            success:function(data){
                document.getElementById('bmi_container2').style.display='none';
                document.getElementById('bmi_container').style.display="";
                bmiChart.series[0].setData(data);
                bmiChart.series[0].setData(data);
            }
        })

    }
    ;
    // ajax 提交
    $('#bmi_update_submit').click(function(){
        var options={
            url:'/highcharts/bmi/update',
            type:'post',
            data: $('#bmi_update_form').serialize(),
            success: bmiUpdateResponse

        };
        $.ajax(options);
        return false;
    });


})



/**
 * 以下是hightchart 的js
 * 身体质量指数
 */
// Apply the theme
//    var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
//    var blood_data=[[1274457600000, 1200], [1274544000000, 1300],[1274630400000, 1250],[1274803200000,1350]]
//    var blood_data=[[Date.parse("2013-01-01"), 1200], [Date.parse("2013-01-01"), 1300],[Date.parse("2013-01-03"), 1250],[Date.parse("2013-01-04"),1350],[Date.parse("2013-01-05"),1350],[Date.parse("2013-01-06"),1359],[Date.parse("2013-04-07"),1389]]
var bmiChart;
var bmichartoption = {
    chart: {
        type: 'area',
        renderTo: 'bmi_container',  //画到id为bmi_container的div容器里
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
                fontbmi: 'bold'
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
                s += '<br/>身体质量指数:'+ point.y +'m/h';
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
            name: '身体质量指数',
            data: [],
            type:'line',
            events:{
                click:function(e){
                    $('#bmi_update_modal').modal('show');
                    $('#bmi_id_update').val(e.point.id);
                    $('#bmi_update_value').val(e.point.y);
                    var unix=e.point.category;
                    var nowDate= new Date(unix);
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    $('#bmi_update_date').val(nowDate);
                }
            }
        }
    ]
};


bmiChart = new Highcharts.StockChart(bmichartoption);
document.getElementById('bmi_container').style.display="none";
document.getElementById('bmi_container2').style.display='';
$.ajax({
    type:'get',
    url:'/highcharts/bmi/all_bmi_data',
    success:function(data){
        if (data.length==0){
            $('#bmi_container2').html('暂无数据')
        }else{
            document.getElementById('bmi_container2').style.display='none';
            document.getElementById('bmi_container').style.display="";
            bmiChart.series[0].setData(data);
        }
    }
})