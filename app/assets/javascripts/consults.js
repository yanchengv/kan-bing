/**
 * Created by yxf on 14-9-19.
 */
//未登录保存咨询
function save_question(){
 //   $('#creatAppointment').modal('show');
    $('#min_login').modal('show');
    setTimeout(function () {
        $('#creatAppointment').modal('hide');
    }, 1000)
}