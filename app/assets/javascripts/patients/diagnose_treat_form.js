/**
 * Created by git on 15-1-21.
 */


//时间控件,显示时间
var nowDate = new Date();
nowDate=nowDate.getFullYear()+'/'+(nowDate.getMonth()+1)+'/'+nowDate.getDate()+'  '+nowDate.getHours()+':'+nowDate.getMinutes();
$('#diagnose_treat_create_time').datetimepicker({
    lang:'ch',
    value: nowDate,
    timepicker:true,
    customformat:'Y-m-d H:m'
    });

$('#main_teller_create_time').datetimepicker({
    lang:'ch',
    value: nowDate,
    timepicker:true,
    customformat:'Y-m-d H:m'
    });

$('#diagnose_create_time').datetimepicker({
    lang:'ch',
    value: nowDate,
    timepicker:true,
    customformat:'Y-m-d H:m'
    });



$('#order_create_time').datetimepicker({
    lang:'ch',
    value: nowDate,
    timepicker:true,
    customformat:'Y-m-d H:m'
    });

$('#order_start_time').datetimepicker({
    lang:'ch',
    value: nowDate,
    timepicker:true,
    customformat:'Y-m-d H:m'
    });




// ajax 诊疗表添加form 提交
$('#diagnose_treat_submit').click(function(){
    $('#diagnoseTreatModal').modal('hide');
    $.ajax({
    url:'/diagnose_treat/create',
    type:'post',
    data: $('#diagnose_treat_form').serialize(),
    success:function(data){

//                $("#zhengliaoshow").html(data);
    $("#diagnose_treat_show").html(data);
    },
    error:function(data){

    alert("添加失败！");
    }
    })
    return false;
    });

//    修改诊疗
function get_update_treat_modal(id,name,create_time,doctor_name){

    $("#diagnoseTreatUpdateModal").modal('show');
    $('#diagnoseTreatUpdateModal').on('shown.bs.modal',function(e){
    $("#diagnose_treat_update_id").val(id);
    $("#treat_update_name").val(name);
    $("#treat_update_create_time").val(create_time);
    $("#doctor_name_update").val(doctor_name);

    });
    };
//    修改诊疗
$('#treat_update_submit').click(function(){
    $('#diagnoseTreatUpdateModal').modal('hide');
    $.ajax({
    url:'/diagnose_treat/diagnose_treat_update',
    type:'post',
    data: $('#diagnose_treat_update_form').serialize(),
    success:function(data){
    $("#diagnose_treat_show").html(data);

    },
    error:function(data){

    alert("添加失败！");
    }
    })
    return false;
    });
// 删除诊疗
function destroy(){
    $.ajax({
        type:'post',
        url:'/diagnose_treat/destroy',
        data:{id:diagnoseTreatID},
        success:function(data){
//                $('#zhengliaoshow').html(data)
            $("#diagnose_treat_show").html(data);
        }
    })

    };

//        修改主诉弹出框
function updateMainTell(diagnose_treat_id,teller,main_teller_create_time,teller_doctor_name,tell_content){
    $('#tellerModal').modal('show');
    $('#tellerModal').on('shown.bs.modal',function(e){
    $('#teller_diagnose_treat_id').val(diagnose_treat_id);
    $('#teller_p').val(teller);
    $('#main_teller_create_time').val(main_teller_create_time);
    $('#teller_doctor_name').val(teller_doctor_name);
    $('#tell_content').val(tell_content);
    })

    };
// ajax 主诉修改form 提交
$('#teller_submit').click(function(){
    $('#tellerModal').modal('hide');
    $.ajax({
    url:'/diagnose_treat/teller',
    type:'post',
    data: $('#teller_form').serialize(),
    success:function(data){
    $("#diagnose_treat_right").html(data);

    },
    error:function(data){

    alert("添加失败！");
    }
    })
    return false;
    });

//        修改诊断 modal弹出框
function updateDiagnose(diagnose_treat_id,diagnose_doctor_name,diagnose_create_time,diagnose_content){
    $('#diagnoseModal').modal('show');
    $('#diagnoseModal').on('shown.bs.modal',function(e){
    $('#u_diagnose_treat_id').val(diagnose_treat_id);
    $('#diagnose_doctor_name').val(diagnose_doctor_name);
    $('#diagnose_create_time').val(diagnose_create_time);
    $('#diagnose_content').val(diagnose_content);
    })
    };


// ajax 诊断修改form 提交
$('#diagnose_submit').click(function(){
    $('#diagnoseModal').modal('hide');
    $.ajax({
    url:'/diagnose_treat/diagnose',
    type:'post',
    data: $('#diagnose_form').serialize(),
    success:function(data){
    $("#diagnose_treat_right").html(data);

    },
    error:function(data){

    alert("添加失败！");
    }
    })
    return false;
    });



//    获取删除诊疗弹出框的方法
var diagnoseTreatName;
var diagnoseTreatID;
function get_destroy_treat_modal(id,name){
    diagnoseTreatName=name;
    diagnoseTreatID=id;
    $('#diagnoseTreatDeleteModal').modal('show');
    $('#diagnoseTreatDeleteModal').on('shown.bs.modal',function(e){
    $('#showTName').html("你确定要删除名字为："+diagnoseTreatName+"的诊疗？");
    });
    };



//        点击左面诊疗标题，右边展现相关主诉，诊断等数据
function showRightDiagonse(diagnoseTreatID,patient_id){
    $.ajax({
        url:'/diagnose_treat/show_treat_right',
        type:'get',
        data:{diagnose_treat_id:diagnoseTreatID,patient_id:patient_id},
        success:function(data){
            $("#diagnose_treat_right").html(data);
        }
    })

    };






//添加医嘱的弹出框
function addDoctorOrder(diagnose_treat_id){
    $('#doctorOrderModal').modal('show');
    $('#doctorOrderModal').on('shown.bs.modal',function(e){
        $.ajax({
            url:'/diagnose_treat/diagnose_health_reports',
            type:'post',
            success:function(data){
                       $("#diagnose_reports").html(data);
            }

        })
    });
    } ;
// ajax 添加医嘱form 提交
$('#doctor_order_submit').click(function(){
    $('#doctorOrderModal').modal('hide');
    $.ajax({
    url:'/diagnose_treat/doctor_order_create',
    type:'post',
    data: $('#doctor_order_form').serialize(),
    success:function(data){
    $("#diagnose_treat_right").html(data);

    },
    error:function(data){

    alert("添加失败！");
    }
    })
    return false;
    });


//        删除医嘱方法
var doctorOrderId;
function  get_destroy_order_modal(doctor_order_id,content){
    doctorOrderId=doctor_order_id
    $("#doctorOrderDeleteModal").modal('show');
    $('#doctorOrderDeleteModal').on('shown.bs.modal',function(e){
    $('#showOrderContent').html("你确定要删除内容为："+content+"的医嘱？");
    });
    };
//    删除医嘱
function destroy_doctor_order(){
    $.ajax({
        type:'get',
        url:'/diagnose_treat/destroy_doctor_order',
        data:{id:doctorOrderId},
        success:function(data){
            $('#diagnose_treat_right').html(data)
        }
    })
    }


