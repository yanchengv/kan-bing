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
            var s = '<b>'+ Highcharts.dateFormat('%Y/%m/%d/%H:%M', this.x) +'</b>';
            $.each(this.points, function(i, point) {
                if (this.series.name=="总胆固醇"){
                    s += '<br/>'+'<div style="color:#2aafa8" >总胆固醇:'+ point.y+'mmol/L</div>'
                }else if(this.series.name=="甘油三酯"){
                    s += '<br/>'+'<div style="color:#0099FF" >甘油三酯:'+ point.y+'mmol/L</div>'
                }else if(this.series.name=="高密度脂蛋白"){
                    s += '<br/>'+'<div style="color:#000000" >高密度脂蛋白:'+ point.y+'mmol/L</div>'
                }else{
                    s += '<br/>'+'<div style="color:#7B68EE" >低密度脂蛋白:'+ point.y+'mmol/L</div>'
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
            fillOpacity: 0.7,
            events:{
                click:function(e){
                    var i=e.point.index
                    var total_cholesterol2=this.chart.series[0].data[i].y
                    var triglyceride2=this.chart.series[1].data[i].y
                    var high_lipoprotein2=this.chart.series[2].data[i].y
                    var low_lipoprotein2=this.chart.series[3].data[i].y
                    var unix=e.point.category;
                    var nowDate = new Date();
//                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate();
                    $('#blood_fat_modal2_update').modal('show');
                    $('#blood_fat_id_update2').val(e.point.id);
                    $('#total_cholesterol2_update').val(total_cholesterol2);
                    $('#triglyceride2_update').val(triglyceride2);
                    $('#high_lipoprotein2_update').val(high_lipoprotein2);
                    $('#low_lipoprotein2_update').val(low_lipoprotein2);
                    $('#blood_fat_measure_time2_update').val(nowDate);

                }
            }

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
            fillOpacity: 0.5,
            events:{
                click:function(e){
                    var i=e.point.index
                    var total_cholesterol2=this.chart.series[0].data[i].y
                    var triglyceride2=this.chart.series[1].data[i].y
                    var high_lipoprotein2=this.chart.series[2].data[i].y
                    var low_lipoprotein2=this.chart.series[3].data[i].y
                    var unix=e.point.category;
                    var nowDate = new Date();
//                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate();
                    $('#blood_fat_modal2_update').modal('show');
                    $('#blood_fat_id_update2').val(e.point.id);
                    $('#total_cholesterol2_update').val(total_cholesterol2);
                    $('#triglyceride2_update').val(triglyceride2);
                    $('#high_lipoprotein2_update').val(high_lipoprotein2);
                    $('#low_lipoprotein2_update').val(low_lipoprotein2);
                    $('#blood_fat_measure_time2_update').val(nowDate);

                }
            }
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
            fillOpacity: 0.5,
            events:{
                click:function(e){
                    var i=e.point.index
                    var total_cholesterol2=this.chart.series[0].data[i].y
                    var triglyceride2=this.chart.series[1].data[i].y
                    var high_lipoprotein2=this.chart.series[2].data[i].y
                    var low_lipoprotein2=this.chart.series[3].data[i].y
                    var unix=e.point.category;
                    var nowDate = new Date();
//                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate();
                    $('#blood_fat_modal2_update').modal('show');
                    $('#total_cholesterol2_update').val(total_cholesterol2);
                    $('#blood_fat_id_update2').val(e.point.id);
                    $('#triglyceride2_update').val(triglyceride2);
                    $('#high_lipoprotein2_update').val(high_lipoprotein2);
                    $('#low_lipoprotein2_update').val(low_lipoprotein2);
                    $('#blood_fat_measure_time2_update').val(nowDate);

                }
            }
        } ,
        {
            name:'低密度脂蛋白',
            data:[],
            type:'line',
            marker: {
                enabled: true,
                fillColor: '#fff',
                lineColor: '#7B68EE',
                lineWidth: 1
                // lineColor: null // inherit from series
            },
            color: '#d3edec',
            lineColor: '#7B68EE',
            fillOpacity: 0.5,
            events:{
                click:function(e){
                    var i=e.point.index
                    var total_cholesterol2=this.chart.series[0].data[i].y
                    var triglyceride2=this.chart.series[1].data[i].y
                    var high_lipoprotein2=this.chart.series[2].data[i].y
                    var low_lipoprotein2=this.chart.series[3].data[i].y
                    var unix=e.point.category;
                    var nowDate = new Date();
//                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
                    nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate();

                    $('#blood_fat_modal2_update').modal('show');
                    $('#blood_fat_id_update2').val(e.point.id);
                    $('#total_cholesterol2_update').val(total_cholesterol2);
                    $('#triglyceride2_update').val(triglyceride2);
                    $('#high_lipoprotein2_update').val(high_lipoprotein2);
                    $('#low_lipoprotein2_update').val(low_lipoprotein2);
                    $('#blood_fat_measure_time2_update').val(nowDate);

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