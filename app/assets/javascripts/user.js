/**
 * Created by git on 14-3-31.
 */

//导航搜索框动态变长特效
$(function(){
    $('#search_doctors').focus(function() {  //设置获得焦点时的方法，让文本框变长
        $(this).animate({width: "250"}, 400 );
        $(this).val(''); //用于清空内容，可选操作
    });

    $('#search_doctors').blur(function() {  //设置失去焦点时的方法，让文本框变短
        $(this).animate({width: "100"}, 400 );
    });
});
//用户简介信息，更多特效
function textFold(id,content){
    var showContent=document.getElementById(id);
    var hideContent= document.getElementById(id+'text')
    if (showContent.innerHTML == "...更多"){
        showContent.innerHTML = "收起";
        showContent.innerHTML =content;
    }else{
        showContent.innerHTML = "...更多";
        hideContent.innerHTML =content.substring(0,60);
    }
}