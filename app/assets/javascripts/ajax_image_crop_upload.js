/**
 * Created with JetBrains RubyMine.
 * User: git
 * Date: 14-2-17
 * Time: 下午9:34
 * To change this template use File | Settings | File Templates.
 */
var x, y, h, w;
var options;
//    上传图片兼容性
function getFullPath(obj) {
    if (obj) {
//ie
        if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
            obj.select();
            return document.selection.createRange().text;
        }
//firefox
        else if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
            if (obj.files) {
                return obj.files.item(0).getAsDataURL();
            }
            return obj.value;
        }
        return obj.value;
    }
}
;

//裁剪图片
function cropPhoto(obj) {
    x = obj.x;
    y = obj.y;
    w = obj.w;
    h = obj.h;
//       当点击确定按钮时, 调用jquery.form.min上传图片,options作为参数上传
    options = {
        dataType: 'json',
        data: {x: x, y: y, w: w, h: h},
        beforeSubmit: showRequest,
        success: showResponse,
        error: showError
    }
}
;
function showRequest() {
    document.getElementById('preview_photo').innerHTML = "<div style='color:#0000FF'>正在上传...</div>";
}
;
function showResponse(responseText, statusText, xhr, $form) {
    $('#photoModal').modal('hide');
    document.getElementById('photo_upload_form').reset();
    document.getElementById('preview_photo').innerHTML = '';
    document.getElementById('myPhoto').src=responseText.url;
    document.getElementById('NavMyPhoto').src=responseText.url;
}
;
function showError() {
    document.getElementById('preview_photo').innerHTML = "<div style='color:#0000FF'>上传失败</div>";
}
;

//上传函数
function upload(file) {
    $('#preview_photo').html('<img id="crop_photo"/>');
    var input_img = document.getElementById("input_photo");
    var fReader = new FileReader();
    fReader.readAsDataURL(input_img.files[0]);
    fReader.onloadend = function (event) {
        var input_img_name = input_img.files[0].name
        var show_img = document.getElementById("crop_photo");
        show_img.src = event.target.result;  //path
        $('#crop_photo').Jcrop({
                boxWidth: 450,
                boxHeight: 0,
                onChange: cropPhoto,
                onSelect: cropPhoto,
                aspectRatio: 2.5 / 3.5,
                setSelect: [20, 68, 250, 350]
            }, function () {
                // Use the API to get the real image size
                var bounds = this.getBounds();
                boundx = bounds[0];
                boundy = bounds[1];
                // Store the API in the jcrop_api variable
                jcrop_api = this;

                // Move the preview into the jcrop container for css positioning
//                $preview.appendTo(jcrop_api.ui.holder);
            }
        );

    }


}

$(document).ready(function () {
    // jquery.form.min插件实现图片ajax提交
    $('#photo_upload_form').submit(function () {
        $(this).ajaxSubmit(options);
        return false;
    });
    //取消上传，清除modal的内容
    $('#cancle').click(function () {
        document.getElementById("photo_upload_form").reset();
        document.getElementById("preview_photo").innerHTML = '';
    });
})
