/**
 * 身体年龄
 */
// Apply the theme
//    var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
//    var blood_data=[[1274457600000, 1200], [1274544000000, 1300],[1274630400000, 1250],[1274803200000,1350]]
//    var blood_data=[[Date.parse("2013-01-01"), 1200], [Date.parse("2013-01-01"), 1300],[Date.parse("2013-01-03"), 1250],[Date.parse("2013-01-04"),1350],[Date.parse("2013-01-05"),1350],[Date.parse("2013-01-06"),1359],[Date.parse("2013-04-07"),1389]]
var body_ageChart;
var body_agechartoption = {
    chart: {
        type: 'area',
        renderTo: 'body_age_container',  //画到id为body_age_container的div容器里
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
                fontbody_age: 'bold'
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
                s += '<br/>身体年龄:'+ point.y +'岁';
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
            name: '身体年龄',
            data: [],
            type:'line',
            events:{
                click:function(e){
                    $('#body_age_update_modal').modal('show');
                    $('#body_age_update_value').val(e.point.y);
                    var unix=e.point.category;
                    var nowDate= new Date(unix);
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    $('#body_age_update_date').val(nowDate);
                }
            }
        }
    ]
};

$(document).ready(function () {
    body_ageChart = new Highcharts.StockChart(body_agechartoption);
    document.getElementById('body_age_container').style.display="none";
    document.getElementById('body_age_container2').style.display='';
    $.ajax({
        type:'get',
        url:'/highcharts/body_age/all_body_age_data',
        success:function(data){
            if (data.length==0){
                $('#body_age_container2').html('暂无数据')
            }else{
                document.getElementById('body_age_container2').style.display='none';
                document.getElementById('body_age_container').style.display="";
                body_ageChart.series[0].setData(data);
            }
        }
    })



//create body_age... 添加身体年龄
    var nowCreateDate = new Date();
    nowCreateDate=nowCreateDate.getFullYear()+'/'+(nowCreateDate.getMonth()+1)+'/'+nowCreateDate.getDate()+'  '+nowCreateDate.getHours()+':'+nowCreateDate.getMinutes();
    //时间控件
    $('#body_age_date').datetimepicker({
        lang:'ch',
        value:nowCreateDate,
        timepicker:false,
        format:'Y-m-d h:m'
    });
    function body_ageCreateResponse(responseText, statusText, xhr, $form) {
        $('#body_age_modal').modal('hide');
        $.ajax({
            type:'get',
            url:'/highcharts/body_age/all_body_age_data',
            success:function(data){
                document.getElementById('body_age_container2').style.display='none';
                document.getElementById('body_age_container').style.display="";
                body_ageChart.series[0].setData(data);
                body_ageChart.series[0].setData(data);
            }
        })

    }
    ;
    // ajax 提交
    $('#body_age_submit').click(function(){
        var options={
            url:'/highcharts/body_age/create',
            type:'post',
            data: $('#body_age_form').serialize(),
            success: body_ageCreateResponse

        };
        $.ajax(options);
        return false;
    });

//    update body_age ...    修改身体年龄
    var nowUpdateDate = new Date();
    nowUpdateDate=nowUpdateDate.getFullYear()+'/'+(nowUpdateDate.getMonth()+1)+'/'+nowUpdateDate.getDate()+'  '+nowUpdateDate.getHours()+':'+nowUpdateDate.getMinutes();
    //时间控件
    $('#body_age_update_date').datetimepicker({
        lang:'ch',
        value:nowUpdateDate,
        timepicker:false,
        format:'Y-m-d h:m'
    });
    function body_ageUpdateResponse(responseText, statusText, xhr, $form) {
        $('#body_age_update_modal').modal('hide');
        $.ajax({
            type:'get',
            url:'/highcharts/body_age/all_body_age_data',
            success:function(data){
                document.getElementById('body_age_container2').style.display='none';
                document.getElementById('body_age_container').style.display="";
                body_ageChart.series[0].setData(data);
                body_ageChart.series[0].setData(data);
            }
        })

    }
    ;
    // ajax 提交
    $('#body_age_update_submit').click(function(){
        var options={
            url:'/highcharts/body_age/update',
            type:'post',
            data: $('#body_age_update_form').serialize(),
            success: body_ageUpdateResponse

        };
        $.ajax(options);
        return false;
    });


})

