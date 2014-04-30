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
            $('#div_right').html('');
            $('#div_right').html(data);

        },
        error: function(data){
            console.log(data);
        }
    });
}
$(function(){
    showHealthRecordsData('/blood_glucose/show');

});
//$(function(){
//    showHealthRecordsData('/blood_glucose/show');
//    $.ajax({
//        type:'post',
//        url:'/blood_glucose/show',
//        success: function(data){
//            var hash = data.data,key,value;
//            for(key in hash){
//                value = hash[key];
//                if(value > 0){
//                    $('#'+key).append('('+value+')')
//                }
//            }
//        },
//        error: function(data){
//            console.log(data);
//        }
//    });
//});
