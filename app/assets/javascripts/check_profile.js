/**
 * Created by git on 14-4-22.
 * 正则表达式
 *验证修改个人资料
 */


var is_username=true;
var is_name=true;
var is_email=true;
var is_phone=true;

function checkUsername(username){
    var patrn= /^[\u4e00-\u9fa5a-zA-Z][\u4e00-\u9fa5a-zA-Z_\d]{1,14}$/;
    var re_username=new RegExp(patrn);
    var re_username2=new RegExp('^[0-9]*$');
    if (re_username.test(username)){
        $.ajax( {
                type:'get',
                url:'/users/check_username',
                data:{username:username},
                success:function(data){
                    var is_use;
                    is_use= data['success'];
                    if (is_use==true){
                        is_username=true;
                        document.getElementById('username_div').innerHTML='<div class="succ-icon"></div>';
                    }else{
                        is_username=false;
                        document.getElementById('username_div').innerHTML='<div class="error-icon">用户名被占用！</div>';
                    }

                }
            }

        )
    }else if(re_username2.test(username)){
        is_username=false;
        document.getElementById('username_div').innerHTML='<div class="error-icon">不能全为数字或空</div>';
    }else{
        is_username=false;
        document.getElementById('username_div').innerHTML='<div class="error-icon">包含非法字符</div>';
    }


};

function checkName(name){
    var c_name=/^\s*$/g;
    var re_name=new RegExp(/^\s*$/g)
    if (re_name.test(name)){
        is_name=false;
        document.getElementById('name_div').innerHTML='<div class="error-icon">姓名不能为空</div>'

    }else{
        is_name=true;
        document.getElementById('name_div').innerHTML='<div class="succ-icon"></div>'

    };
};
function checkEmail(email) {
    var re_email = new RegExp("^([a-zA-Z0-9]+[_|\_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$");
    if(re_email.test(email)){
        $.ajax({
            type:'get',
            url:'/users/check_email',
            data:{email:email},
            success:function(data){
                var is_use;
                is_use= data['success'];
                if(is_use==true) {
                    is_email=true;
                    document.getElementById('email_div').innerHTML='<div class="succ-icon"></div>'
                }else{
                    is_email=false;
                    document.getElementById('email_div').innerHTML='<div class="error-icon">邮箱已注册</div>'
                }

            }
        })

    }
    else  {
        is_email=false;
        document.getElementById('email_div').innerHTML='<div class="error-icon">格式不正确</div>'

    } ;

};
function checkPhone(phone){
    var c_phome=/^(?:13\d|15[89])-?\d{5}(\d{3}|\*{3})$/;
    var re_phone= new RegExp(c_phome);
    if (re_phone.test(phone)){
        $.ajax({
            type:'get',
            url:'/users/check_phone',
            data:{phone:phone},
            success:function(data){
                var is_use;
                is_use= data['success'];
                if(is_use==true) {
                    is_phone=true;
                    document.getElementById('phone_div').innerHTML='<div class="succ-icon"></div>'
                }else{
                    is_phone=false;
                    document.getElementById('phone_div').innerHTML='<div class="error-icon">电话已占用</div>'
                }
            }
        })
    }else{
        is_phone=false;
        document.getElementById('phone_div').innerHTML='<div class="error-icon">格式不正确</div>'
    };
};



function check_content(){
    if (is_username!=true||is_name!=true||is_email!=true||is_phone!=true){
        return false;
    }
};

var options = {
//    dataType: 'json',
    beforeSubmit: check_content,
    success: function(data){
//      document.getElementById('setting_profile_div').innerHTML=data;
    }

//    error: ''
}


$(document).ready(function(){
    $('#profile_update_id').submit(function(){
        $(this).ajaxSubmit(options);
        return false;
    })
})
