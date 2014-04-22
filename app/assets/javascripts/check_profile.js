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
console.log(username)
var re_username=new RegExp(patrn)
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
    document.getElementById('username_div').innerHTML='验证通过!';
    }else{
    is_username=false;
    document.getElementById('username_div').innerHTML='用户名被占用！';
    }


}
}

)
}else{
    is_username=false;
    document.getElementById('username_div').innerHTML='用户名不能只包含纯数字，不能包含@符号！';
    }


};

function checkName(name){
    var c_name=/^\s*$/g;
    var re_name=new RegExp(/^\s*$/g)
    if (re_name.test(name)){
    is_name=false;
    document.getElementById('name_div').innerHTML='姓名不能为空！'

    }else{
    is_name=true;
    document.getElementById('name_div').innerHTML='验证通过!'

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
    document.getElementById('email_div').innerHTML='验证通过!'
    }else{
    is_email=false;
    document.getElementById('email_div').innerHTML='此邮箱已注册！'
    }

}
})

}
else  {
    is_email=false;
    document.getElementById('email_div').innerHTML='邮箱格式不正确！'

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
    document.getElementById('phone_div').innerHTML='验证通过!'
    }else{
    is_phone=false;
    document.getElementById('phone_div').innerHTML='电话已占用！'
    }
}
})
}else{
    is_phone=false;
    document.getElementById('phone_div').innerHTML='手机格式不正确！'
    };
};



function checkSubmit(){
    console.log(is_username)
    if (is_username==true&&is_name==true&&is_email==true&&is_phone==true){

    } else{

    return false;
    }
}

function check_content(){
    console.log(is_username)
    if (is_username==true&&is_name==true&&is_email==true&&is_phone==true){
          console.log('提交哦')
    } else{
        console.log('不提交哦')
        return false;
    }
}
