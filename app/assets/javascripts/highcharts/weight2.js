//weight html 的js

$(document).ready(function () {

/**
 * Created 以下是highchart的js.
 */
// Apply the theme
//    var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
//    var blood_data=[[1274457600000, 1200], [1274544000000, 1300],[1274630400000, 1250],[1274803200000,1350]]
//    var blood_data=[[Date.parse("2013-01-01"), 1200], [Date.parse("2013-01-01"), 1300],[Date.parse("2013-01-03"), 1250],[Date.parse("2013-01-04"),1350],[Date.parse("2013-01-05"),1350],[Date.parse("2013-01-06"),1359],[Date.parse("2013-04-07"),1389]]
var weightChart2;
var weightchartoption2 = {
    chart: {
        type: 'area',
        renderTo: 'weight_container3',  //画到id为weight_container的div容器里
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
                s += '<br/>体重:'+ point.y +'kg';
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
            name: '体重',
            data: [],
            type:'line',
            events:{
                click:function(e){
                    $('#weight_update_modal2').modal('show');
                    $('#weight_id_update2').val(e.point.id)
                    $('#weight_update_value2').val(e.point.y);
                    var unix=e.point.category;
                    var nowDateUpdate2= new Date(unix);
                    nowDateUpdate2=nowDateUpdate2.getFullYear()+'/'+(nowDateUpdate2.getMonth()+1)+'/'+nowDateUpdate2.getDate()+'  '+nowDateUpdate2.getHours()+':'+nowDateUpdate2.getMinutes();
                    $('#weight_update_date2').val(nowDateUpdate2);
                }
            }
        }
    ]
};

weightChart2 = new Highcharts.StockChart(weightchartoption2);
document.getElementById('weight_container3').style.display="none";
document.getElementById('weight_container4').style.display='';
$.ajax({
    type:'get',
    url:'/weight/all_weight_data',
    success:function(data){
        if (data.length==0){
            $('#weight_container4').html('暂无数据')
        }else{
            document.getElementById('weight_container4').style.display='none';
            document.getElementById('weight_container3').style.display="";
            weightChart2.series[0].setData(data);
        }
    }
});


    var nowDate2 = new Date();
    nowDate2=nowDate2.getFullYear()+'/'+(nowDate2.getMonth()+1)+'/'+nowDate2.getDate()+'  '+nowDate2.getHours()+':'+nowDate2.getMinutes();
//时间控件
    $('#weight_date2').datetimepicker({
        lang:'ch',
        value:nowDate2,
        timepicker:true,
        customformat:'Y-m-d H:m'
    });


//时间控件
    $('#weight_update_date2').datetimepicker({
        lang:'ch',
        value:nowDate,
        timepicker:true,
//    time:'Y-m-d H:m',
        customformat:'Y-m-d H:m'
    });
//    新建体重后的响应
    function weightCreateResponse2(responseText, statusText, xhr, $form) {
        $('#weight_modal2').modal('hide');
        $.ajax({
            type:'get',
            url:'/weight/all_weight_data',
            success:function(data){
                document.getElementById('weight_container4').style.display='none';
                document.getElementById('weight_container3').style.display="";
                weightChart2.series[0].setData(data);
            }
        })

    }
    ;

//    修改体重后的响应
    function weightUpdateResponse2(responseText, statusText, xhr, $form) {
        $('#weight_update_modal2').modal('hide');
        $.ajax({
            type:'get',
            url:'/weight/all_weight_data',
            success:function(data){
                document.getElementById('weight_container4').style.display='none';
                document.getElementById('weight_container3').style.display="";
                weightChart2.series[0].setData(data);
            }
        })

    }
    ;

// create  ajax 提交
    $('#weight_submit2').click(function(){
        var options={
            url:'/weight/create',
            type:'post',
            data: $('#weight_form2').serialize(),
            success: weightCreateResponse2

        };
        $.ajax(options);
        return false;
    });


// update ajax 提交
    $('#weight_update_submit2').click(function(){
        var options={
            url:'/weight/update',
            type:'post',
            data: $('#weight_update_form2').serialize(),
            success: weightUpdateResponse2

        };
        $.ajax(options);
        return false;
    });


});
