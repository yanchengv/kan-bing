/**
 * Created by git on 14-2-27.
 */

$.ajax({
    type: 'get',
    url: '/doctors/index_doctors_list',
    data: 'json',
    success: function (data) {
    $('#doctor_list').html(data)
    },
error: function (data) {
    console.log('error:'+data)

    }
})

// <![CDATA[
    var textDiv = document.getElementById("rollText");
    var textList = textDiv.getElementsByTagName("a");
    if (textList.length > 4) {
        var textDat = textDiv.innerHTML;
        var br = textDat.toLowerCase().indexOf("<br", textDat.toLowerCase().indexOf("<br") + 3);
//var textUp2 = textDat.substr(0,br);
        textDiv.innerHTML = textDat + textDat + textDat.substr(0, br);
        textDiv.style.cssText = "position:absolute; top:0";
        var textDatH = textDiv.offsetHeight;
        MaxRoll();
    }
    var minTime, maxTime, divTop, newTop = 0;
    function MinRoll() {
        newTop++;
        if (newTop <= divTop + 24) {
            textDiv.style.top = "-" + newTop + "px";
        } else {
            clearInterval(minTime);
            maxTime = setTimeout(MaxRoll, 5000);
        }
    }
    function MaxRoll() {
        divTop = Math.abs(parseInt(textDiv.style.top));
        if (divTop >= 0 && divTop < textDatH - 24) {
            minTime = setInterval(MinRoll, 1);
        } else {
            textDiv.style.top = 0;
            divTop = 0;
            newTop = 0;
            MaxRoll();
        }
    }
    // ]]>


function change_doctor(img_url, introduction, name, hospital, department,id) {
    document.getElementById('img_url').src = img_url;
    document.getElementById('img_url').alt = name;
    document.getElementById('img_url').title = name;
    document.getElementById('introduction').innerHTML = introduction;
    document.getElementById('name').innerHTML = name;
    document.getElementById('hospital').innerHTML = hospital;
    document.getElementById('department').innerHTML = department;
    document.getElementById('href_img').href='/doctors/show_doctor?id='+id
    }
function change_doc(img_url, introduction, name, hospital, department) {
    document.getElementById('default').src = img_url;
    document.getElementById('default').alt = name;
    document.getElementById('default').title = name;
    document.getElementById('introduction').innerHTML = introduction;
    document.getElementById('name').innerHTML = name;
    document.getElementById('hospital').innerHTML = hospital;
    document.getElementById('department').innerHTML = department;

    }
var Speed_1 = 10; //速度(毫秒)
var Space_1 = 10; //每次移动(px)
var PageWidth_1 = 110; //翻页宽度
var interval_1 = 100000; //翻页间隔时间
var fill_1 = 0; //整体移位
var MoveLock_1 = false;
var MoveTimeObj_1;
var MoveWay_1 = "right";
var Comp_1 = 0;
var AutoPlayObj_1 = null;
function GetObj(objName) {
    if (document.getElementById) {
    return eval('document.getElementById("' + objName + '")')
    } else {
    return eval('document.all.' + objName)
    }
}
function AutoPlay_1() {
    clearInterval(AutoPlayObj_1);
    AutoPlayObj_1 = setInterval('ISL_GoDown_1();ISL_StopDown_1();', interval_1)
    }
function ISL_GoUp_1() {
    if (MoveLock_1)return;
    clearInterval(AutoPlayObj_1);
    MoveLock_1 = true;
    MoveWay_1 = "left";
    MoveTimeObj_1 = setInterval('ISL_ScrUp_1();', Speed_1);
    }
function ISL_StopUp_1() {
    if (MoveWay_1 == "right") {
    return
    }
;
clearInterval(MoveTimeObj_1);
if ((GetObj('ISL_Cont_1').scrollLeft - fill_1) % PageWidth_1 != 0) {
    Comp_1 = fill_1 - (GetObj('ISL_Cont_1').scrollLeft % PageWidth_1);
    CompScr_1()
    } else {
    MoveLock_1 = false
    }
AutoPlay_1()
}
function ISL_ScrUp_1() {
    if (GetObj('ISL_Cont_1').scrollLeft <= 0) {
    GetObj('ISL_Cont_1').scrollLeft = GetObj('ISL_Cont_1').scrollLeft + GetObj('List1_1').offsetWidth
    }
GetObj('ISL_Cont_1').scrollLeft -= Space_1
}
function ISL_GoDown_1() {
    clearInterval(MoveTimeObj_1);
    if (MoveLock_1)return;
    clearInterval(AutoPlayObj_1);
    MoveLock_1 = true;
    MoveWay_1 = "right";
    ISL_ScrDown_1();
    MoveTimeObj_1 = setInterval('ISL_ScrDown_1()', Speed_1)
    }
function ISL_StopDown_1() {
    if (MoveWay_1 == "left") {
    return
    }
;
clearInterval(MoveTimeObj_1);
if (GetObj('ISL_Cont_1').scrollLeft % PageWidth_1 - (fill_1 >= 0 ? fill_1 : fill_1 + 1) != 0) {
    Comp_1 = PageWidth_1 - GetObj('ISL_Cont_1').scrollLeft % PageWidth_1 + fill_1;
    CompScr_1()
    } else {
    MoveLock_1 = false
    }
AutoPlay_1()
}
function ISL_ScrDown_1() {
    if (GetObj('ISL_Cont_1').scrollLeft >= GetObj('List1_1').scrollWidth) {
    GetObj('ISL_Cont_1').scrollLeft = GetObj('ISL_Cont_1').scrollLeft - GetObj('List1_1').scrollWidth
    }
GetObj('ISL_Cont_1').scrollLeft += Space_1
}
function CompScr_1() {
    if (Comp_1 == 0) {
    MoveLock_1 = false;
    return
    }
var num, TempSpeed = Speed_1, TempSpace = Space_1;
if (Math.abs(Comp_1) < PageWidth_1 / 2) {
    TempSpace = Math.round(Math.abs(Comp_1 / Space_1));
    if (TempSpace < 1) {
    TempSpace = 1
    }
}
if (Comp_1 < 0) {
        if (Comp_1 < -TempSpace) {
        Comp_1 += TempSpace;
        num = TempSpace
        } else {
        num = -Comp_1;
        Comp_1 = 0
        }
    GetObj('ISL_Cont_1').scrollLeft -= num;
            setTimeout('CompScr_1()', TempSpeed)
    } else {
        if (Comp_1 > TempSpace) {
        Comp_1 -= TempSpace;
        num = TempSpace
        } else {
        num = Comp_1;
        Comp_1 = 0
        }
    GetObj('ISL_Cont_1').scrollLeft += num;
            setTimeout('CompScr_1()', TempSpeed)
    }
    }

