/**
 * Created by yxf on 14-9-19.
 */
//未登录保存咨询
function save_question(){
    $('#min_login').modal('show');
    setTimeout(function () {
        $('#creatAppointment').modal('hide');
    }, 1000)
}
//
function submit_question(){
    var consult_content = document.getElementById('consult_content').value;
    if(consult_content == ''){
        alert('咨询内容不能为空！');
    }else{
        document.getElementById('question_form').submit();
    }
}