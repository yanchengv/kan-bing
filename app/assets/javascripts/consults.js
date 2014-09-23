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
//咨询保存
function submit_question(){
    var consult_content = document.getElementById('consult_content').value;
    var consulting_by = document.getElementById('consulting_by').value;
    if(consult_content == ''){
        alert('咨询内容不能为空！');
    }else{
        $.ajax({
            type: 'post',
            url: '/consult_questions',
            data: {consult_question: {consult_content: consult_content, consulting_by: consulting_by}},
            success: function (data) {
                if (data['success'] == true) {
                    window.location.reload();
                } else {
                    alert(data['error']);
                }
            }
        })
    }
}
//咨询修改
function edit_question(id) {
    var show_msg = document.getElementById('question_' + id);
    show_msg.style.display = 'none';
    var hid_msg = document.getElementById('question_edit_' + id);
    hid_msg.style.display = 'block';
}
//咨询修改的取消
function cel_edit(id) {
    var show_msg = document.getElementById('question_' + id);
    show_msg.style.display = 'block';
    var hid_msg = document.getElementById('question_edit_' + id);
    hid_msg.style.display = 'none';
}
//咨询提交
function submit_edit(id){
    var consult_content = document.getElementById('consult_content_' + id).value;
    if (consult_content == '') {
        alert('咨询内容不能为空！');
    } else {
        $.ajax({
            type: 'put',
            url: '/consult_questions/'+id,
            data: {consult_question: {consult_content: consult_content}},
            success: function (data) {
                if (data['success'] == true) {
                    document.getElementById('question_show_' + id).innerHTML = consult_content;
                    cel_edit(id);
                } else {
                    alert(data['error']);
                }
            }
        })
    }
}
//删除咨询
function del_question(id){
    if (confirm("是否将此留言信息删除?")) {
        $.ajax({
            type: 'delete',
            url: '/consult_questions/' + id,
            success: function (data) {
                if (data['success'] == true) {
                    document.getElementById('question_' + id).remove();
                    document.getElementById('question_edit_' + id).remove();
                } else {
                    alert(data['error']);
                }
            }
        })
    } else return false;

}
//搜索咨询
function search_consult_questions(){
    document.getElementById('search_consult_question').submit();
}