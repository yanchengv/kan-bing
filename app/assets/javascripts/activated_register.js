/**
 * Created with JetBrains RubyMine.
 * User: git
 * Date: 14-8-26
 * Time: 下午4:55
 * To change this template use File | Settings | File Templates.
 */

var username_flag=false
var pwd_flag=false
var con_pwd_flag=false


function checkUserName(username){
    var patrn= /^[\u4e00-\u9fa5a-zA-Z][\u4e00-\u9fa5a-zA-Z_\d]{1,14}$/;
    var re_username=new RegExp(patrn);
    var re_username2=new RegExp('^[0-9]*$');
    if (re_username.test(username)){
        $.ajax( {
                type:'get',
                url:'/sessions/check_username',
                data:{username:username},
                success:function(data){
                    var is_use;
                    is_use= data['success'];
                    if (is_use==true){
                        username_flag=true;
                        document.getElementById('username_div').innerHTML='<div class="succ-icon"></div>';
                    }else{
                        username_flag=false;
                        document.getElementById('username_div').innerHTML='<div class="error-icon">用户名被占用！</div>';
                    }

                }
            }

        )
    }else if(re_username2.test(username)){
        username_flag=false;
        document.getElementById('username_div').innerHTML='<div class="error-icon">不能全为数字或空</div>';
    }else{
        username_flag=false;
        document.getElementById('username_div').innerHTML='<div class="error-icon">包含非法字符</div>';
    }


};
function check_new(password){
    var reg_blank=new RegExp(/^\s*$/g)
    var reg_num=new RegExp('^[0-9]*$');
    var reg_letter=new RegExp('^[a-zA-Z]*$')
    if(reg_blank.test(password)){
        pwd_flag=false
        document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">不能为空！</div>'
    }
//else if (reg_num.test(new_password)){
//    new_pwd_flag=false
//    document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">不能全为数字！</div>'
//    }else if(reg_letter.test(new_password)){
//    new_pwd_flag=false
//    document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">不能全为字母！</div>'
//    }
    else if(password.length>16 || password.length<4){
        pwd_flag=false
        document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">长度应为4-16位！</div>'
    }
    else{
        pwd_flag=true
        document.getElementById('new_pwd_div').innerHTML='<div class="succ-icon"></div>';
    }

}
function check_new2(password_confirmation){
    if (pwd_flag&&password_confirmation==$('#user_pass').val()){
        con_pwd_flag=true
        document.getElementById('new_pwd2_div').innerHTML='<div class="succ-icon"></div>';
    }else{
        con_pwd_flag=false
        document.getElementById('new_pwd2_div').innerHTML='<div class="error-icon">两次密码不一致！</div>'
    }
}
$(document).ready(function(){
    $(":submit[id=register_form]").click(function(check){
        if(username_flag!=true||pwd_flag!=true||con_pwd_flag!=true){
            alert("表单填写有误，不能提交表单！");
            check.preventDefault();//此处阻止提交表单
        }
    });
    document.getElementById('register_form').setAttribute('disabled','disabled')
});