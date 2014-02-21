/**
 * Created by git on 14-2-20.
 */

function showHealthRecordsData(dataUrl){
    $.ajax( {
        type:'post',
        dataType:'json',
        url:dataUrl,
        data:'dfdf',
        success: success(data),
        error: error(data)


    } )
}

function success(data){
      alert(success)
    console.log(data)
    }

function error(){
    alert(error)
}
