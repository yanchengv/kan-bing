/**
 * Created by git on 15-1-21.
 */


//时间控件,显示时间
var nowDate = new Date();
nowDate = nowDate.getFullYear() + '/' + (nowDate.getMonth() + 1) + '/' + nowDate.getDate() + '  ' + nowDate.getHours() + ':' + nowDate.getMinutes();
$('#diagnose_treat_create_time').datetimepicker({
    lang: 'ch',
    value: nowDate,
    timepicker: true,
    customformat: 'Y-m-d H:m'
});

$('#main_teller_create_time').datetimepicker({
    lang: 'ch',
    value: nowDate,
    timepicker: true,
    customformat: 'Y-m-d H:m'
});

$('#diagnose_create_time').datetimepicker({
    lang: 'ch',
    value: nowDate,
    timepicker: true,
    customformat: 'Y-m-d H:m'
});


$('#order_create_time').datetimepicker({
    lang: 'ch',
    value: nowDate,
    timepicker: true,
    customformat: 'Y-m-d H:m'
});

$('#order_start_time').datetimepicker({
    lang: 'ch',
    value: nowDate,
    timepicker: true,
    customformat: 'Y-m-d H:m'
});


// ajax 诊疗表添加form 提交
$('#diagnose_treat_submit').click(function () {
    $('#diagnoseTreatModal').modal('hide');
    $.ajax({
        url: '/diagnose_treat/create',
        type: 'post',
        data: $('#diagnose_treat_form').serialize(),
        success: function (data) {

//                $("#zhengliaoshow").html(data);
            $("#diagnose_treat_show").html(data);
        },
        error: function (data) {

            alert("添加失败！");
        }
    })
    return false;
});

//    修改诊疗
function get_update_treat_modal(id, name, create_time, doctor_name) {

    $("#diagnoseTreatUpdateModal").modal('show');
    $('#diagnoseTreatUpdateModal').on('shown.bs.modal', function (e) {
        $("#diagnose_treat_update_id").val(id);
        $("#treat_update_name").val(name);
        $("#treat_update_create_time").val(create_time);
        $("#doctor_name_update").val(doctor_name);

    });
};
//    修改诊疗
$('#treat_update_submit').click(function () {
    $('#diagnoseTreatUpdateModal').modal('hide');
    $.ajax({
        url: '/diagnose_treat/diagnose_treat_update',
        type: 'post',
        data: $('#diagnose_treat_update_form').serialize(),
        success: function (data) {
            $("#diagnose_treat_show").html(data);

        },
        error: function (data) {

            alert("添加失败！");
        }
    })
    return false;
});
// 删除诊疗
function destroy() {
    $.ajax({
        type: 'post',
        url: '/diagnose_treat/destroy',
        data: {id: diagnoseTreatID},
        success: function (data) {
//                $('#zhengliaoshow').html(data)
            $("#diagnose_treat_show").html(data);
        }
    })

};

//        修改主诉弹出框
function updateMainTell(diagnose_treat_id, teller, main_teller_create_time, teller_doctor_name, tell_content) {
    $('#tellerModal').modal('show');
    $('#tellerModal').on('shown.bs.modal', function (e) {
        $('#teller_diagnose_treat_id').val(diagnose_treat_id);
        $('#teller_p').val(teller);
        $('#main_teller_create_time').val(main_teller_create_time);
        $('#teller_doctor_name').val(teller_doctor_name);
        $('#tell_content').val(tell_content);
    })

};
// ajax 主诉修改form 提交
$('#teller_submit').click(function () {
    $('#tellerModal').modal('hide');
    $.ajax({
        url: '/diagnose_treat/teller',
        type: 'post',
        data: $('#teller_form').serialize(),
        success: function (data) {
            $("#diagnose_treat_right").html(data);

        },
        error: function (data) {

            alert("添加失败！");
        }
    })
    return false;
});

//        修改诊断 modal弹出框
function updateDiagnose(diagnose_treat_id, diagnose_doctor_name, diagnose_create_time, diagnose_content) {
    $('#diagnoseModal').modal('show');
    $('#diagnoseModal').on('shown.bs.modal', function (e) {
        $('#u_diagnose_treat_id').val(diagnose_treat_id);
        $('#diagnose_doctor_name').val(diagnose_doctor_name);
        $('#diagnose_create_time').val(diagnose_create_time);
        $('#diagnose_content').val(diagnose_content);
    })
};


// ajax 诊断修改form 提交
$('#diagnose_submit').click(function () {
    $('#diagnoseModal').modal('hide');
    $.ajax({
        url: '/diagnose_treat/diagnose',
        type: 'post',
        data: $('#diagnose_form').serialize(),
        success: function (data) {
            $("#diagnose_treat_right").html(data);

        },
        error: function (data) {

            alert("添加失败！");
        }
    })
    return false;
});


//    获取删除诊疗弹出框的方法
var diagnoseTreatName;
var diagnoseTreatID;
function get_destroy_treat_modal(id, name) {
    diagnoseTreatName = name;
    diagnoseTreatID = id;
    $('#diagnoseTreatDeleteModal').modal('show');
    $('#diagnoseTreatDeleteModal').on('shown.bs.modal', function (e) {
        $('#showTName').html("你确定要删除名字为：" + diagnoseTreatName + "的诊疗？");
    });
};


//        点击左面诊疗标题，右边展现相关主诉，诊断等数据
function showRightDiagonse(diagnoseTreatID, patient_id) {
    $.ajax({
        url: '/diagnose_treat/show_treat_right',
        type: 'get',
        data: {diagnose_treat_id: diagnoseTreatID, patient_id: patient_id},
        success: function (data) {
            $("#diagnose_treat_right").html(data);
        }
    })

};


//翻页医嘱依据时，时临时保存选中了哪些健康档案
var reportIds = {}
function checkReports(id) {
    if (reportIds[id]) {
//        取消选中
        delete reportIds[id]

    } else {
//        添加选中
        reportIds[id] = id;

    }


};

//修改翻页医嘱依据时，时临时保存选中了哪些健康档案
var updateReportIds={}
function checkUpdateReports(id) {

    if (updateReportIds[id]) {
//        取消选中
        delete updateReportIds[id]

    } else {
//        添加选中
        updateReportIds[id] = id;

    }


};




//获取添加医嘱的弹出框
function addDoctorOrder(diagnose_treat_id) {
    $('#doctorOrderModal').modal('show');
    $('#doctorOrderModal').on('shown.bs.modal', function (e) {
        $.ajax({
            url: '/diagnose_treat/diagnose_health_reports',
            type: 'post',
            success: function (data) {
                $("#diagnose_reports").html(data);
            }

        })
    });
    $('#doctorOrderModal').on('hidden.bs.modal', function (e) {
//        模态框消失 的同时清空 reportIds
        reportIds = {}

    });
};


// ajax 添加医嘱form 提交
$('#doctor_order_submit').click(function () {


    var doctor_order = {};
    doctor_order["patient_id"] = $("#order_patient_id").val();
    doctor_order["doctor_id"] = $("#order_doctor_id").val();
    doctor_order["diagnose_treat_id"] = $("#order_treat_id").val();
    doctor_order["create_time"] = $("#order_create_time").val();
    doctor_order["start_time"] = $("#order_start_time").val();
    doctor_order["valid_time"] = $("#order_valid_time").val();
    doctor_order["doctor_name"] = $("#order_doctor_name").val();
    doctor_order["executor"] = $("#order_executor").val();
    doctor_order["order_type"] = $("#order_type").val();
    doctor_order["content"] = $("#order_content").val();

    $('#doctorOrderModal').modal('hide');
    $.ajax({
        url: '/diagnose_treat/doctor_order_create',
        type: 'post',
        data: {doctor_order: doctor_order, reportIds: reportIds},
        success: function (data) {
            $("#diagnose_treat_right").html(data);

        },
        error: function (data) {

            alert("添加失败！");
        }
    })
    return false;
});


//获取修改医嘱的弹出框

function get_update_order_modal(order_id,create_time,start_time,valid_time,doctor_name,executor,order_type,content,accroding) {
    $('#updateDoctorOrderModal').modal('show');
    $('#updateDoctorOrderModal').on('shown.bs.modal', function (e) {

                $('#update_doctor_order_id').val(order_id);
                $('#update_order_create_time').val(create_time);
                $('#update_order_start_time').val(start_time);
                $('#update_order_valid_time').val(valid_time);
                $('#update_order_doctor_name').val(doctor_name);
                $('#update_order_executor').val(executor);
                $('#update_order_type').val(order_type);
                $('#update_order_content').val(content);

                if(accroding!=0){
                    accrodingArr=accroding.split(",");
                    $.each(accrodingArr,function(n,value){
                        updateReportIds[value]=value
                        console.log(updateReportIds[value]);
                    })
                    console.log(accrodingArr[0]);
                }

        $.ajax({
            url: '/diagnose_treat/update_reports',
            type: 'post',
            success: function (data) {
                $("#update_diagnose_reports").html(data);
            }

        });
    })
};


// ajax 修改医嘱form 提交
$('#update_doctor_order_submit').click(function () {

    var doctor_order = {};
    doctor_order["patient_id"] = $("#update_order_patient_id").val();
    doctor_order["doctor_id"] = $("#update_order_doctor_id").val();
    doctor_order["diagnose_treat_id"] = $("#update_order_treat_id").val();
    doctor_order["doctor_order_id"] = $("#update_doctor_order_id").val();
    doctor_order["create_time"] = $("#update_order_create_time").val();
    doctor_order["start_time"] = $("#update_order_start_time").val();
    doctor_order["valid_time"] = $("#update_order_valid_time").val();
    doctor_order["doctor_name"] = $("#update_order_doctor_name").val();
    doctor_order["executor"] = $("#update_order_executor").val();
    doctor_order["order_type"] = $("#update_order_type").val();
    doctor_order["content"] = $("#update_order_content").val();

    $('#updateDoctorOrderModal').modal('hide');
    $.ajax({
        url: '/diagnose_treat/doctor_order_update',
        type: 'post',
        data: {doctor_order: doctor_order, reportIds: updateReportIds},
        success: function (data) {
            $("#diagnose_treat_right").html(data);

        },
        error: function (data) {

            alert("添加失败！");
        }
    })
    return false;
    return false;
});


//  删除医嘱方法
var doctorOrderId;
function get_destroy_order_modal(doctor_order_id, content) {
    doctorOrderId = doctor_order_id
    $("#doctorOrderDeleteModal").modal('show');
    $('#doctorOrderDeleteModal').on('shown.bs.modal', function (e) {
        $('#showOrderContent').html("你确定要删除内容为：" + content + "的医嘱？");
    });
};
//    删除医嘱
function destroy_doctor_order() {
    $.ajax({
        type: 'get',
        url: '/diagnose_treat/destroy_doctor_order',
        data: {id: doctorOrderId},
        success: function (data) {
            $('#diagnose_treat_right').html(data)
        }
    })
}
//医嘱来源选择
function showOrderSource(value){
    if(value == 'standard'){
        document.getElementById('order_type_tr').style.display = 'block';
        document.getElementById('medical_divice_tr').style.display = 'block';
        document.getElementById('order_content_tr').style.display = 'none';
    }
    if (value == 'custom') {
        document.getElementById('order_type_tr').style.display = 'none';
        document.getElementById('medical_divice_tr').style.display = 'none';
        document.getElementById('order_content_tr').style.display = 'block';
    }
}
//根据医嘱标准类型选择医嘱标准
$("#advice_type").on("change", function (event) {
    var type_id = $('#advice_type').val();
    $.get('/diagnose_treat/get_advices?type_id=' + type_id, function (data) {
        var res = '<select width=300><option value="">---请选择---</option>';
        for (var k in data['medical_advices']) {
            if (data['medical_advices'].hasOwnProperty(k)) {
                res += '<option value="' + k + '">' + data['medical_advices'][k] + '</option> '
            }
        }
        res += '</select>';
        $("#content_sel").html(res);
    });
});
//下拉框select2
jQuery(document).ready(function () {
    jQuery("#advice_type").select2();
    jQuery("#content_sel").select2();
    jQuery("#update_advice_type").select2();
    jQuery("#content_update_sel").select2();
    jQuery("#update_diagnose_type").select2();
    jQuery("#update_medical_diagnose").select2();
});
//修改时的医嘱来源
function update_source(value){
    if (value == 'standard') {
        document.getElementById('update_type_tr').style.display = 'block';
        document.getElementById('medical_divice_update_tr').style.display = 'block';
        document.getElementById('order_content_update_tr').style.display = 'none';
    }
    if (value == 'custom') {
        document.getElementById('update_type_tr').style.display = 'none';
        document.getElementById('medical_divice_update_tr').style.display = 'none';
        document.getElementById('order_content_update_tr').style.display = 'block';
    }
}
//根据医嘱标准类型选择医嘱标准(update时)
$("#update_advice_type").on("change", function (event) {
    var type_id = $('#update_advice_type').val();
    $.get('/diagnose_treat/get_advices?type_id=' + type_id, function (data) {
        var res = '<select width=300><option value="">---请选择---</option>';
        for (var k in data['medical_advices']) {
            if (data['medical_advices'].hasOwnProperty(k)) {
                res += '<option value="' + k + '">' + data['medical_advices'][k] + '</option> '
            }
        }
        res += '</select>';
        $("#content_update_sel").html(res);
    });
});

//诊断来源切换
function update_diagnose_source(value){
    if (value == 'standard') {
        document.getElementById('update_diagnose_type_tr').style.display = 'block';
        document.getElementById('update_medical_diagnose_tr').style.display = 'block';
        document.getElementById('content_diagnose').style.display = 'none';
    }
    if (value == 'custom') {
        document.getElementById('update_diagnose_type_tr').style.display = 'none';
        document.getElementById('update_medical_diagnose_tr').style.display = 'none';
        document.getElementById('content_diagnose').style.display = 'block';
    }
}
//根据诊断标准类型选择诊断信息
$("#update_diagnose_type").on("change", function (event) {
    var type_id = $('#update_diagnose_type').val();
    $.get('/diagnose_treat/get_diagnoses?type_id=' + type_id, function (data) {
        var res = '<select width=300><option value="">---请选择---</option>';
        for (var k in data['medical_diagnoses']) {
            if (data['medical_diagnoses'].hasOwnProperty(k)) {
                res += '<option value="' + k + '">' + data['medical_diagnoses'][k] + '</option> '
            }
        }
        res += '</select>';
        $("#update_medical_diagnose").html(res);
    });
});



