/**
 * Created by git on 14-3-27.
 */

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