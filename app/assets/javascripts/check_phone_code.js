/**
 * Created by git on 14-8-28.
 */
var is_phone = true
var is_code=true
$(document).ready(function(){
    $(":submit[id=send_next_button]").click(function(check){
        if(is_code!=true){
            check.preventDefault();//此处阻止提交表单
            document.getElementById('send_next_button').setAttribute('disabled','disabled')
        }
    });
    $(":submit[id=activated_form]").click(function(check){
        if(is_phone!=true){
            alert("表单填写有误，不能提交表单！");
            check.preventDefault();//此处阻止提交表单
        }
    });

});
function checkMobilePhone(mobile_phone){
    var c_phone=/1[3|5|7|8|][0-9]{9}/;
    var re_phone= new RegExp(c_phone);
    if (re_phone.test(mobile_phone)){
        $.ajax({
            url: '/phone/check_phone?phone='+mobile_phone,
            success: function(data){
                if (data['success']==true){
                    is_phone=true
                    document.getElementById('mobile_phone_div').innerHTML='<div class="succ-icon"></div>'
                }else {
                    is_phone=false
                    document.getElementById('mobile_phone_div').innerHTML='<div class="error-icon">手机号错误！</div>'
                }
            }
        });
    }else{
        is_phone=false
        document.getElementById('mobile_phone_div').innerHTML='<div class="error-icon">格式不正确</div>'
    }
}

function checkVerifyCode(code) {
    var user_id = $('#phone_user_id').val()
    var re_code = new RegExp(/^\s*$/g)
    if (re_code.test(code)) {
        is_code=false;
        document.getElementById('verify_code_div').innerHTML='<div class="error-icon">验证码不能为空</div>'

    }else{
        $.ajax({
            url: '/phone/check_verify_code?code=' + code + '&user_id=' + user_id,
            success: function (data) {
                if (data['success'] == true) {
                    is_code = true
                    document.getElementById('verify_code_div').innerHTML='<div class="succ-icon"></div>'
                } else {
                    is_code = false
                    document.getElementById('verify_code_div').innerHTML='<div class="error-icon">验证码错误！</div>'
                }
            }
        });
    }
}