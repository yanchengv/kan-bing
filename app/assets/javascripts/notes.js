<!--文章全选-->
//全选
function select_all(){
    var checkAll = document.getElementById('check_all').checked;
    var obj = document.getElementsByName("check_note");
    if (checkAll == false) {
        for (var i = 0; i < obj.length; i++) {
            obj[i].checked = false;
        }
    } else {
        for (var i = 0; i < obj.length; i++) {
            obj[i].checked = true;
        }
    }
}
//批量删除
function batch_delete(){
    var obj = document.getElementsByName("check_note");
    if (confirm("是否确认删除?")) {
        var ids = '(';
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].checked == true) {
              ids += obj[i].value + ',';
            }
        }
        ids = ids.substr(0, ids.length - 1) + ')';
        if(ids == ')'){
            alert('请选择删除项！');
        }else{
            $.ajax({
                type: 'post',
                url: '/notes/batch_delete',
                data: {ids: ids},
                success: function (data) {
                    if (data['success'] == true) {
                        window.location.href = '/notes';
                    } else {
                        alert('批量操作失败！');
                    }
                }
            })
        }
    }
}
//添加分类
function add_note_type() {
    $('#crate_cons_modal').modal('show').on('shown.bs.modal', function () {
    });
}
//保存分类
function note_type_save() {
    var tag_name = document.getElementById('tag_name_id').value;
    $.ajax({
        type: 'post',
        url: '/note_types/async_create',
        data: {tag_name: tag_name},
        success: function (data) {
            if (data['success'] == true) {
                var sel_type = document.getElementById('sel_type');
                var options = '';
                for (var i = 0; i < data['note_types'].length; i++) {
                    if (data['note_types'][i].name == tag_name){
                        options += '<option value="' + data['note_types'][i].id + '" selected="selected" >' + data['note_types'][i].name + '</option>';
                    }else{
                        options += '<option value="' + data['note_types'][i].id + '" >' + data['note_types'][i].name + '</option>';
                    }
                }
                sel_type.innerHTML = options;
                $('#crate_cons_modal').modal('hide').on('shown.bs.modal', function () {
                });
            } else {
                alert(data['errors']);
            }
        }
    })
}
//批量功能的显示问题
function batch_manage(){
    var batch_manage = document.getElementById('batch_manage').innerHTML;
    var batch_area = document.getElementById('batch_area');
    var objs = document.getElementsByName("check_note");
    if (batch_manage == '批量管理'){
        document.getElementById('batch_manage').innerHTML = "退出批量管理";

        if (batch_area.style.display == "none"){
            batch_area.style.display = "block";
        }

        for (var i = 0; i < objs.length; i++) {
            if (objs[i].style.display == "none") {
                objs[i].style.display = 'block';
            }
        }
    }else{
        document.getElementById('batch_manage').innerHTML = "批量管理";
        if (batch_area.style.display == "block") {
            batch_area.style.display = "none";
        }
        for (var i = 0; i < objs.length; i++) {
            if (objs[i].style.display == "block") {
                objs[i].style.display = 'none';
            }
        }
    }
}
//添加文章类型
function show_add_type(){
    var add_note_type = document.getElementById('add_note_type');
    add_note_type.style.display = 'block';
}
//文章类型添加表单的取消
function cel_show(){
    var add_note_type = document.getElementById('add_note_type');
    add_note_type.style.display = 'none';
}
//文章类型修改
function edit_type_show(id){
    var show_msg = document.getElementById('tr_show_'+id);
    show_msg.style.display = 'none';
    var hid_msg = document.getElementById('tr_hid_'+id);
    hid_msg.style.display = 'block';
}
//文章类型修改的取消
function cel_type(id){
    var show_msg = document.getElementById('tr_show_' + id);
    show_msg.style.display = 'block';
    var hid_msg = document.getElementById('tr_hid_' + id);
    hid_msg.style.display = 'none';
}
//文章置顶操作
function to_top(id){
    var is_top_id = document.getElementById('is_top_'+id);
    if (is_top_id.checked == true){
        $.ajax({
            type: 'post',
            url: '/notes/is_top',
            data: {id: id, str: true},
        success: function (data) {
            if (data['success'] == true) {
                is_top_id.checked == false;
            } else {
                alert('操作失败！');
            }
        }
        })
    }else{
        $.ajax({
            type: 'post',
            url: '/notes/is_top',
            data: {id: id, str: false},
            success: function (data) {
                if (data['success'] == true) {
                    is_top_id.checked == true;
                } else {
                    alert('操作失败！');
                }
            }
        })
    }
}
//文章点赞功能
function note_admired(note_id, user_id){
    $.ajax({
        type: 'post',
        url: '/note_admireds',
        data: {note_admired: {user_id: user_id, note_id: note_id}},
        success:function(data){
            if(data['success'] == true){
                document.getElementById('admired_span').innerHTML = data['count'];
            }else{
                alert(data['errors']);
            }
        }
    })
}
//取消点赞
function cel_admired(note_id, user_id){
    $.ajax({
        type: 'post',
        url: '/note_admireds/del_admired',
        data: {user_id: user_id, note_id: note_id},
        success: function (data) {
            if (data['success'] == true) {
                document.getElementById('admired_span').innerHTML = data['count'];
            } else {
                alert(data['errors']);
            }
        }
    })
}
//显示分类修改
function update_type_show(){
    var update_type_div = document.getElementById('update_type_div');
    if (update_type_div.style.display == 'none'){
        update_type_div.style.display = 'block'
    }else{
        update_type_div.style.display = 'none'
    }
}
//修改分类
function update_types(id){
    var obj = document.getElementsByName("check_note");
    var ids = '(';
    for (var i = 0; i < obj.length; i++) {
        if (obj[i].checked == true) {
            ids += obj[i].value + ',';
        }
    }
    ids = ids.substr(0, ids.length - 1) + ')';
    if (ids == ')') {
        alert('请选择修改分类项！');
    } else {
        $.ajax({
            type: 'post',
            url: '/notes/batch_update_type',
            data: {ids: ids, type_id: id},
            success: function (data) {
                if (data['success'] == true) {
                    window.location.href = '/notes';
                } else {
                    alert('批量修改分类失败！');
                }
            }
        })
    }
}
//清空标签的输入框
var flag = true;
function clear_tag_text() {
    if (flag) {
        document.getElementById("tag_name").value = '';
        flag = false;
    }
}
//搜索文章
function search_notes(){
   document.getElementById('submit_search').submit();
}
//回车搜索文章
/*
document.onkeydown = function (event) {
    event = event ? event : (window.event ? window.event : null);
    if (event.keyCode == 13) {
        //执行的方法
        document.getElementById('submit_search').submit();
    }
}
*/


function  showShareWindow(){
    $('#localShare').modal('show')
}

function  ShareToMypatients(note_id){
    if(note_id){
        $('#localShare').modal('hide');
        $.ajax({
            type:'post',
            url:'/notes/'+note_id+'/share',
            data:'json',
            success:function(data){
              //  $('#doctorschedule').html(data)
                console.log(data);
                console.log(data.success);
                if (true == data.success ){
                    alert('分享成功！')
                }
            },
            error:function(data){
                console.log(data)
                alert('抱歉，分享出现异常！')
            }
        })


    }

}

