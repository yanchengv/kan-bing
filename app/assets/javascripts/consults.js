/**
 * Created by yxf on 14-9-19.
 */
//未登录保存咨询
function save_question() {
    $('#min_login').modal('show');
    setTimeout(function () {
        $('#creatAppointment').modal('hide');
    }, 1000)
}
//咨询保存
function submit_question() {
    var consult_content = document.getElementById('consult_content').value;
    var consulting_by = document.getElementById('consulting_by').value;
    if (consult_content == '') {
        alert('咨询内容不能为空！');
    } else {
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
function submit_edit(id) {
    var consult_content = document.getElementById('consult_content_' + id).value;
    if (consult_content == '') {
        alert('咨询内容不能为空！');
    } else {
        $.ajax({
            type: 'put',
            url: '/consult_questions/' + id,
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
function del_question(id) {
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
function search_consult_questions() {
    document.getElementById('search_consult_question').submit();
}
//修改回复
function edit_result(id) {
    var result = document.getElementById('result_' + id);
    result.style.display = 'none';
    var hid_result = document.getElementById('result_edit_' + id);
    hid_result.style.display = 'block';
}
//删除回复
function del_result(id) {
    if (confirm("是否将此回复信息删除?")) {
        $.ajax({
            type: 'delete',
            url: '/consult_results/' + id,
            success: function (data) {
                if (data['success'] == true) {
                    document.getElementById('result_' + id).remove();
                    document.getElementById('result_edit_' + id).remove();
                } else {
                    alert(data['error']);
                }
            }
        })
    } else return false;
}
//回复修改取消
function cel_result(id) {
    var result = document.getElementById('result_edit_' + id);
    result.style.display = 'none';
    var hid_result = document.getElementById('result_' + id);
    hid_result.style.display = 'block';
}
//提交回复
function submit_result(id) {
    var consult_id = document.getElementById('consult_id').value;
    var respond_content = document.getElementById('respond_content').value;
    if (respond_content == '') {
        alert('回复内容不能为空！');
    } else {
        $.ajax({
            type: 'post',
            url: '/consult_results',
            data: {consult_result: {respond_content: respond_content, consult_id: consult_id}},
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
//添加举报界面
function add_consult_accuse(id, source, content, str) {
    if (str == 'question') {
        document.getElementById('source_accuse').innerHTML += source;
    } else {
        document.getElementById('source_accuse').innerHTML += source;
    }
    document.getElementById('accuse_content').innerHTML = content;
    document.getElementById('source_id').value = id;
    $('#crate_cons_modal').modal('show').on('shown.bs.modal', function () {
    });
}
//提交举报信息
function submit_accuse(str) {
    var objs = document.getElementsByName("reason");
    var reasons = '';
    for (var i = 0; i < objs.length; i++) {
        if (objs[i].checked == true) {
            reasons += objs[i].value + ',';
        }
    }
    var id = document.getElementById('source_id').value;
    reasons = reasons.substr(0, reasons.length - 1);
    if (reasons == ''){
        alert('请选择举报原因！')
    }else{
        if (str == 'question') {
            $.ajax({
                type: 'post',
                url: '/consult_accuses',
                data: {consult_accuse: {reason: reasons, question_id: id}},
                success: function (data) {
                    if (data['success'] == true) {
                        window.location.reload();
                    } else {
                        alert(data['error']);
                    }
                }
            })
        } else {
            $.ajax({
                type: 'post',
                url: '/consult_accuses',
                data: {consult_accuse: {reason: reasons, result_id: id}},
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
}