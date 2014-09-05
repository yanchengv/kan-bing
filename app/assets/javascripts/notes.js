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
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].checked == true) {
                $.ajax({
                        type: 'delete',
                        url: '/notes/' + obj[i].value
                    }

                )
            }
        }
    }
}
//添加分类
function add_note_type(doctor_id) {
    $('#crate_cons_modal').modal('show').on('shown.bs.modal', function () {
        document.getElementById('note_type_doctor_id').value = doctor_id;
    })
}