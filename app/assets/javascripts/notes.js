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

                }
            })
        }
    }
    window.location.href = '/notes';
}
//添加分类
function add_note_type(doctor_id) {
    $('#crate_cons_modal').modal('show').on('shown.bs.modal', function () {
        document.getElementById('note_type_doctor_id').value = doctor_id;
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
            data: {id: id, str: true}
        })
    }else{
        $.ajax({
            type: 'post',
            url: '/notes/is_top',
            data: {id: id, str: false}
        })
    }
    window.location.href='/notes';

}