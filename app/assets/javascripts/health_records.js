/**
 * Created by git on 14-2-20.
 */

function showHealthRecordsData(dataUrl){
    $.ajax({
        type:'post',
        url:dataUrl,
        success: function(data){
            $('#div_right').html(data);
        },
        error: function(data){
            console.log(data);
        }
    });
}

//function success(data){
//      alert('success')
//    console.log(data)
//    }
//
//function error(){
//    alert('error')
//}
