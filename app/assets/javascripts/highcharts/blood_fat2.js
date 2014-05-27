/**
 * Created by git on 14-5-22.
 */

var bloodfatChart2;
bloodfatChartOption2 = {
    chart: {
        type: 'area',
        renderTo: 'blood_fat_container3',  //画到id为blood_container的div容器里
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
            var s = '<b>'+ Highcharts.dateFormat('%Y/%m/%d', this.x) +'</b>';
            $.each(this.points, function(i, point) {
                s += '<br/>'+this.series.name+':'+ point.y +'mmHg';
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
            name: '总胆固醇',
            data: [],
            type:'line',
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#2aafa8',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',
            lineColor: '#2aafa8',
            fillOpacity: 0.7

        },
        {
            name:'甘油三酯',
            data:[],
            type:'line',
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#0099FF',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',
            lineColor: '#0099FF',
            fillOpacity: 0.5
        },
        {
            name:'高密度脂蛋白',
            type:'line',
            data:[],
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#000000',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',
            lineColor: '#000000',
            fillOpacity: 0.5
        } ,
        {
            name:'低密度脂蛋白',
            data:[],
            type:'line',
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#33CC66',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',
            lineColor: '#33CC66',
            fillOpacity: 0.5
        }
    ]
};

$(document).ready(function () {
    bloodfatChart2 = new Highcharts.StockChart(bloodfatChartOption2)
    document.getElementById('blood_fat_container3').style.display='none';
    document.getElementById('blood_fat_container4').style.display='';
//        获取数据
    $.ajax({
        type:'get',
        url:'/blood_fat/all_blood_fat',
        success:function(data){
            var total_cholesterol_data=data['blood_fat_data']['total_cholesterol_data']
            var triglyceride_data=data['blood_fat_data']['triglyceride_data']
            var high_lipoprotein_data=data['blood_fat_data']['high_lipoprotein_data']
            var low_lipoprotein=data['blood_fat_data']['low_lipoprotein']
            if (total_cholesterol_data.length==0&&triglyceride_data.length==0&&high_lipoprotein_data.length==0&&low_lipoprotein.length==0){
                $("#blood_fat_container4").html("暂无数据")
            }else{
                document.getElementById('blood_fat_container4').style.display='none';
                document.getElementById('blood_fat_container3').style.display="";
                bloodfatChart2.series[0].setData(total_cholesterol_data)
                bloodfatChart2.series[1].setData(triglyceride_data)
                bloodfatChart2.series[2].setData(high_lipoprotein_data)
                bloodfatChart2.series[3].setData(low_lipoprotein)
            }


        }
    })
//    }


})