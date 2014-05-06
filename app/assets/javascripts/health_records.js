/**
 * Created by git on 14-2-20.
 */

function showHealthRecordsData(dataUrl){
    $.ajax({
        type:'post',
        url:dataUrl,
//        beforeSend: function(){
//            $('#div_right').html('<p>正在加载数据。。。</p>')
//        },
        success: function(data){
//            $('#div_right').html('');
            $('#div_right').html(data);

        },
        error: function(data){
            console.log(data);
        }
    });
}

$(function(){
    showHealthRecordsData('/health_records/dicom');
    $.ajax({
        type:'post',
        url:'/health_records/get_data',
        success: function(data){
            var hash = data.data,key,value;
            for(key in hash){
                value = hash[key];
                if(value > 0){
                    $('#'+key).append('('+value+')')
                }
            }
        },
        error: function(data){
            console.log(data);
        }
    });
    $('#inspection').click(function(){
        showHealthRecordsData('/health_records/inspection');
    });
    $('#checkout').click(function(){
        showHealthRecordsData('/health_records/inspection_report2');
    })
    $('.undefined').click(function(){
        showHealthRecordsData('/health_records/undefined_other');
    })
    $('#inspection_all').click(function(){
        showHealthRecordsData('/health_records/dicom');
    });
});
