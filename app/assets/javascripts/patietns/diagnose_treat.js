/**
 * Created by git on 15-1-21.
 */


//滚动条
$(function() {
    var glen = $("#gundiv ul li").length;
    $("#gundiv ul").css("height",292 * (glen));
    $("#gundiv li").hover(function(){$("#gundiv li").removeClass("zslion");$(this).addClass("zslion");},function(){$(this).removeClass("zslion");})
    });
$("#zsgun").hScrollPane({
    mover:"ul",
    moverW:function(){return $("#zsgun li").length*292-17;}(),
    showArrow:true,
    handleCssAlter:"draghandlealter"
    });

document.getElementById("zsgun").style.height=document.getElementById("zhenliao").scrollHeight+"px";

