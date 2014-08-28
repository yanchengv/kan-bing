var is_phone = false
var is_code = false
$(document).ready(function(){
    $(":submit[id=activated_form]").click(function(check){
        if(is_phone!=true||is_code!=true){
            alert("表单填写有误，不能提交表单！");
            check.preventDefault();//此处阻止提交表单
        }
    });
    document.getElementById('activated_form').setAttribute('disabled','disabled')
});
function check_phone(phone){
    var c_phone=/1[3|5|7|8|][0-9]{9}/;
    var re_phone= new RegExp(c_phone);
    if (re_phone.test(phone)){
        $.ajax({
            type:'get',
            url:'/sessions/check_phone',
            data:{phone:phone},
            success:function(data){
                var is_use;
                is_use= data['success'];
                if(is_use==true) {
                    is_phone=true;
                    document.getElementById('phone_div').innerHTML='<div class="succ-icon"></div>'
                }else{
                    var msg = data['msg']
                    is_phone=false;
                    document.getElementById('phone_div').innerHTML='<div class="error-icon">'+msg+'</div>'
                }
            }
        })
    }else{
        is_phone=false;
        document.getElementById('phone_div').innerHTML='<div class="error-icon">格式不正确</div>'
    };
}
function check_code(code){
    var phone = $('#mobile_phone_id').val()
    if (is_phone==false || phone==''  ) {
        document.getElementById('code_div').innerHTML='<div class="error-icon">请先输入正确的手机号！</div>'
    }else {
        $.ajax({
            type:'get',
            url:'/sessions/check_code',
            data:{phone:phone,code:code},
            success:function(data){
                var is_use;
                is_use= data['success'];
                if(is_use==true) {
                    is_code=true;
                    document.getElementById('code_div').innerHTML='<div class="succ-icon"></div>'
                }else{
                    is_code=false;
                    document.getElementById('code_div').innerHTML='<div class="error-icon">验证码错误</div>'
                }
            }
        })
    }


}