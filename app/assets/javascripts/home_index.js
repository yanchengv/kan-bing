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


$.ajax({
    type: 'get',
    //url: '/homes/index_area_list',
    data: 'json',
    success: function (data) {
        //$('#').html(data)
    },
    error: function (data) {
        c//onsole.log('error:'+data)

    }
})
//// <![CDATA[
//    var textDiv = document.getElementById("rollText");
//    var textList = textDiv.getElementsByTagName("a");
//    if (textList.length > 4) {
//        var textDat = textDiv.innerHTML;
//        var br = textDat.toLowerCase().indexOf("<br", textDat.toLowerCase().indexOf("<br") + 3);
////var textUp2 = textDat.substr(0,br);
//        textDiv.innerHTML = textDat + textDat + textDat.substr(0, br);
//        textDiv.style.cssText = "position:absolute; top:0";
//        var textDatH = textDiv.offsetHeight;
//        MaxRoll();
//    }
//    var minTime, maxTime, divTop, newTop = 0;
//    function MinRoll() {
//        newTop++;
//        if (newTop <= divTop + 24) {
//            textDiv.style.top = "-" + newTop + "px";
//        } else {
//            clearInterval(minTime);
//            maxTime = setTimeout(MaxRoll, 5000);
//        }
//    }
//    function MaxRoll() {
//        divTop = Math.abs(parseInt(textDiv.style.top));
//        if (divTop >= 0 && divTop < textDatH - 24) {
//            minTime = setInterval(MinRoll, 1);
//        } else {
//            textDiv.style.top = 0;
//            divTop = 0;
//            newTop = 0;
//            MaxRoll();
//        }
//    }
//    // ]]>
//

function change_doctor(img_url, introduction, name, hospital, department,id) {
    document.getElementById('img_url').src = img_url;
    document.getElementById('img_url').alt = name;
    document.getElementById('img_url').title = name;
    document.getElementById('introduction').innerHTML = introduction.substr(0,95);
    document.getElementById('name').innerHTML = name;
    document.getElementById('hospital').innerHTML = hospital;
    document.getElementById('department').innerHTML = department;
    document.getElementById('doctor_id').value = id;
  //  document.getElementById('href_img').href='/doctors/show_doctor?id='+id;
    }
function b(){
    h = $(window).height()-500;
    t = $(document).scrollTop();
    if(t > h){
        $('#gotop').show();
    }else{
        $('#gotop').hide();
    }
}
$(document).ready(function(e) {
    b();
    $('#gotop').click(function(){
        $(document).scrollTop(0);
    })
});

$(window).scroll(function(e){
    b();
})




