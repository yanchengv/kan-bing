$(document).ready(function () {
    /**
     * Created by git on 14-9-9.
     * 以下使html js
     */
//时间控件
var nowDate = new Date();
nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
//   create 弹窗窗口的时间input
$('#perssure_measure_date2').datetimepicker({
    lang:'ch',
    value: nowDate,
    timepicker:true,
    customformat:'Y-m-d H:m'
});


//修改窗口的时间input

    $('#perssure_measure_date2_update').datetimepicker({
        lang:'ch',
        value: nowDate,
        timepicker:true,
        customformat:'Y-m-d H:m'
    });
function pressureCreateResponse2(responseText, statusText, xhr, $form) {
    $('#blood_pressure_modal2').modal('hide');
//        更新数据
    $.ajax({
        type:'get',
        url:'/blood_pressure/all_blood_pressure',
        success:function(data){
            document.getElementById('blood_pressure_container4').style.display='none';
            document.getElementById('blood_pressure_container3').style.display="";
            pressureChart2.series[0].setData(data['pressure_data']['systolic_pressure_data'])
            pressureChart2.series[1].setData(data['pressure_data']['diastolic_pressure_data'])
        }
    })
}
;

    function pressureUpdateResponse2(responseText, statusText, xhr, $form) {
        $('#blood_pressure_update_modal2').modal('hide');
//        更新数据
        $.ajax({
            type:'get',
            url:'/blood_pressure/all_blood_pressure',
            success:function(data){
                document.getElementById('blood_pressure_container4').style.display='none';
                document.getElementById('blood_pressure_container3').style.display="";
                pressureChart2.series[0].setData(data['pressure_data']['systolic_pressure_data'])
                pressureChart2.series[1].setData(data['pressure_data']['diastolic_pressure_data'])
            }
        })
    }
    ;
function pressureError(data){
    $('#blood_pressure_modal2').modal('hide');
}
// ajax 血压 create 提交
$('#blood_pressure_submit2').click(function(){
    var options={
        url:'/blood_pressure/create',
        type:'post',
        data: $('#blood_pressure_form2').serialize(),
        success: pressureCreateResponse2,
        error: pressureError

    };
    $.ajax(options);
    return false;
});

    // ajax 血压 update 提交
    $('#blood_pressure_update_submit2').click(function(){
        var options={
            url:'/blood_pressure/update',
            type:'post',
            data: $('#blood_pressure_update_form2').serialize(),
            success: pressureUpdateResponse2,
            error: pressureError

        };
        $.ajax(options);
        return false;
    });



/**
 * 以下是highcahrt的js
 * Created by git on 14-5-8.
 */

// Apply the theme
//    var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
//    var blood_data=[[1274457600000, 1200], [1274544000000, 1300],[1274630400000, 1250],[1274803200000,1350]]
//    var blood_data=[[Date.parse("2013-01-01"), 1200], [Date.parse("2013-01-01"), 1300],[Date.parse("2013-01-03"), 1250],[Date.parse("2013-01-04"),1350],[Date.parse("2013-01-05"),1350],[Date.parse("2013-01-06"),1359],[Date.parse("2013-04-07"),1389]]

var pressureChart2;
pressureChartOption2 = {
    chart: {
        type: 'area',
        renderTo: 'blood_pressure_container3',  //画到id为blood_container的div容器里
        spacingTop: 5,
        spacingLeft:20

    },
    legend: {
        enabled: false
    },
    plotOptions: {
        series: {
            marker: {
                enabled: true
                // lineColor: null // inherit from series
            },
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

        buttons: [
            {
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
            week: '%m-%d',
            month: '%m-%d',
            year: '%Y'
        },
        labels: {
            formatter: function() {
                return  Highcharts.dateFormat('%m-%d', this.value);
            }
        }



    },
    yAxis: {
        ridLineColor: '#cdcdcd',
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
                if (this.series.name=="收缩压"){
                    s += '<br/>'+'<div style="color:#000000" >收缩压:'+ point.y+'mmHg</div>'
                }else{
                    s += '<br/>'+'<div style="color:#2aafa8" >舒张压:'+ point.y+'mmHg</div>'
                }


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
            name: '收缩压',
            type:'line',
            data: [],
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#000000',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#e8f6f5',
            lineColor:'#000000',
            fillOpacity: 0.7,
            events:{
                click:function(e){
                    var i=e.point.index
                    var systolic_pressure2=this.chart.series[0].data[i].y
                    var diastolic_pressure2=this.chart.series[1].data[i].y
                   $('#blood_pressure_update_modal2').modal('show');
                    $('#systolic_pressure2_update').val(systolic_pressure2);
                    $('#diastolic_pressure2_update').val(diastolic_pressure2);
                    $('#blood_pressure_id_update2').val(e.point.id);
                    var unix=e.point.category;
                    var nowDate= new Date(unix);
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    $('#perssure_measure_date2_update').val(nowDate);
                }
            }

        },
        {
            name:'舒张压',
            data:[],
            type:'line',
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#2aafa8',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',   //tip消息边框的颜色
            lineColor: '#2aafa8',
            fillOpacity: 0.5,
            events:{
                click:function(e){
                    var i=e.point.index
                    var systolic_pressure2=this.chart.series[0].data[i].y
                    var diastolic_pressure2=this.chart.series[1].data[i].y
                    $('#blood_pressure_update_modal2').modal('show');
                    $('#systolic_pressure2_update').val(systolic_pressure2);
                    $('#diastolic_pressure2_update').val(diastolic_pressure2);
                    $('#blood_pressure_id_update2').val(e.point.id);
                    var unix=e.point.category;
                    var nowDate= new Date(unix);
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    $('#perssure_measure_date2_update').val(nowDate);
                }
            }
        }
    ]
};
//为数据添加索引,方便修改数据
function prepare(dataArray) {
    return dataArray.map(function (item, index) {
        return {x: item[0], y: item[1], myIndex: index};
    });
};




    pressureChart2 = new Highcharts.StockChart(pressureChartOption2)
    document.getElementById('blood_pressure_container3').style.display='none';
    document.getElementById('blood_pressure_container4').style.display='';
//        获取数据
    $.ajax({
        type:'get',
        url:'/blood_pressure/all_blood_pressure',
        success:function(data){
            var systolic_pressure_data=data['pressure_data']['systolic_pressure_data']
            var diastolic_pressure_data=data['pressure_data']['diastolic_pressure_data']
            if (systolic_pressure_data.length==0&&diastolic_pressure_data.length==0){
                $("#blood_pressure_container4").html("暂无数据")
            }else{
                document.getElementById('blood_pressure_container4').style.display='none';
                document.getElementById('blood_pressure_container3').style.display="";
                pressureChart2.series[0].setData(systolic_pressure_data)
                pressureChart2.series[1].setData(diastolic_pressure_data)
            }


        }
    })
//    }


})