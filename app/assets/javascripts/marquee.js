/**
 * Created with JetBrains RubyMine.
 * User: git
 * Date: 13-12-17
 * Time: 下午2:17
 * To change this template use File | Settings | File Templates.
 */
var Marquee = function(id){
    var container = document.getElementById(id), original = container.getElementsByTagName("dt")[0], clone = container.getElementsByTagName("dd")[0], speed = 80;
    clone.innerHTML = original.innerHTML;
    var rolling = function(){
        if (container.scrollTop == clone.offsetTop) {
            container.scrollTop = 0;
        }
        else {
            container.scrollTop++;
        }
    }
    var timer = setInterval(rolling, speed)//设置定时器
    container.onmouseover = function(){
        clearInterval(timer)
    }//鼠标移到marquee上时，清除定时器，停止滚动
    container.onmouseout = function(){
        timer = setInterval(rolling, speed)
    }//鼠标移开时重设定时器
}
window.onload = function(){
    Marquee("marquee");
}

function change_video(new_url){
    if (new_url == '' || new_url == 'undefined') {
        document.getElementById('play').innerHTML=' <img src="video.jpg" width="220" height="140" alt="暂无视频" >';
    }else{
        document.getElementById('play').innerHTML='<embed src="'+ new_url +'" width="220" height="140" type="application/x-shockwave-flash"></embed>';
    }

}
function MM_swapImgRestore() { //v3.0
    var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
    var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
        var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
            if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
    var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
        d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
    var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
        if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
