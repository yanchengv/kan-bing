/**
 * Created by git on 14-8-28.
 */

    var new_pwd_flag=true
    var new_pwd2_flag=true
    function check_new(new_password){
        var reg_blank=new RegExp(/^\s*$/g)
        var reg_num=new RegExp('^[0-9]*$');
        var reg_letter=new RegExp('^[a-zA-Z]*$')
        if(reg_blank.test(new_password)){
        new_pwd_flag=false
        document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">不能为空！</div>'
        }
//else if (reg_num.test(new_password)){
//    new_pwd_flag=false
//    document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">不能全为数字！</div>'
//    }else if(reg_letter.test(new_password)){
//    new_pwd_flag=false
//    document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">不能全为字母！</div>'
//    }
        else if(new_password.length>16 || new_password.length<4){
        new_pwd_flag=false
        document.getElementById('new_pwd_div').innerHTML='<div class="error-icon">长度应为4-16位！</div>'
        }
        else{
        new_pwd_flag=true
        document.getElementById('new_pwd_div').innerHTML='<div class="succ-icon"></div>';
        }

        }
    function check_new2(password_confirmation){
        var reg_blank=new RegExp(/^\s*$/g)
        if(reg_blank.test(password_confirmation)){
            new_pwd2_flag=false
            document.getElementById('new_pwd2_div').innerHTML='<div class="error-icon">不能为空！</div>'
        }
        else if (new_pwd_flag&&password_confirmation==$('#new_password').val()){
        new_pwd2_flag=true
        document.getElementById('new_pwd2_div').innerHTML='<div class="succ-icon"></div>';
        }else{
        new_pwd2_flag=false
        document.getElementById('new_pwd2_div').innerHTML='<div class="error-icon">两次密码不一致！</div>'
        }
        }

    $(document).ready(function(){
        $(":submit[id=rest_pwd_button]").click(function(check){
            if(new_pwd_flag!=true||new_pwd2_flag!=true){
                alert("表单中填写有误，不能提交表单！");
                check.preventDefault();//此处阻止提交表单
            }
        });
        });
