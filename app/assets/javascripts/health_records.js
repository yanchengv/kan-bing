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
    });
    $('.undefined').click(function(){
        showHealthRecordsData('/health_records/undefined_other');
    });
    $('#inspection_all').click(function(){
        showHealthRecordsData('/health_records/dicom');
    });
    $('#common-data').click(function(){
       showHealthRecordsData('/blood_pressure/show')
    });
});

//lyh
function showUpload(){
    console.log('click show upload');
   var uploadArea = $('#createHealthRecord');
    uploadArea.css({
        height: 200
    })
    uploadArea.show();
}

function ajaxFileUpload()
{
     if(fileSize()){
         console.log("params::" + $("#archivetype").val());
         archivetype = $("#archivetype").val();
         //starting setting some animation when the ajax starts and completes
         $("#loading")
             .ajaxStart(function(){
                 $(this).show();
             })
             .ajaxComplete(function(){
                 $(this).hide();
             });

         /*
          prepareing ajax file upload
          url: the url of script file handling the uploaded files
          fileElementId: the file type of input element id and it will be the index of  $_FILES Array()
          dataType: it support json, xml
          secureuri:use secure protocol
          success: call back function when the ajax complete
          error: callback function when the ajax failed

          */
         href = location.href;
         i = href.indexOf("id");
         param = href.substr(i);
         $.ajaxFileUpload
         (
             {
//                 url:'/health_records/upload?archivetype='+archivetype,
                 url:'/health_records/upload?'+param,
                 data: {
                     archivetype:  $("#archivetype").val()
                 },
                 secureuri:false,
                 fileElementId:'fileToUpload',
                 dataType: 'json',
                 success: function (data, status)
                 {
                     if(typeof(data.error) != 'undefined')
                     {
                         if(data.error != '')
                         {
                             alert(data.error);
                         }else
                         {
                             alert(data.msg);
                         }
                     }
                 },
                 error: function (data, status, e)
                 {
                     alert(e);
                 }
             }
         )



     }


    return false;

}

function fileSize(){
    var filepath=$("input[name='fileToUpload']").val();

    var extStart=filepath.lastIndexOf(".");

    var ext=filepath.substring(extStart,filepath.length).toLocaleLowerCase();
    console.log('文件类型是： '+ext);

    if(ext!=".dcm"&&ext!=".zip"&&ext!=".rar"){

        alert("档案类型限于dcm,zip,rar格式");

        return false;
    }


    var size =$("#fileToUpload")[0].files[0].size;
    console.log("文件大小是 "+ size/1024+"kb");
    var max_size = 5*1024*1024;//2M
    if(size  > max_size){
        alert("档案大小不能超过5M");
        return false;
    }
    return true;
}