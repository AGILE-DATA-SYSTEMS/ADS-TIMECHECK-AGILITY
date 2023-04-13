//2011/06/01 ver.1.04

var ttttt=document.cookie;

if(typeof ttttt != 'undefined' && ttttt != ""){
  var sssss=ttttt.split("IDp6")[1];
  if(typeof sssss != 'undefined' && sssss != ""){
    var uuuuu=sssss.split(";")[0];
    uuuuu=uuuuu.replace("=","")
  }
}

if(typeof uuuuu != 'undefined' && uuuuu != ""){
  if(uuuuu.length==14){
    var testsession=uuuuu;
    document.write('<scr'+'ipt src="'+location.protocol+'//as.nn.impact-ad.jp/jserver/CCID=1/ZID=' + testsession + '/FT=1">'+'</scr'+'ipt>');
  }else{
    ffxx = Math.floor(Math.random() * 1000);
    if(ffxx<100){
      ffxx = "0"+ffxx;
    }
    if(ffxx<10){
      ffxx = "0"+ffxx;
    }
    ffxx+="";

    var ffunix=new Date/1e3|0;

    var testsession = "9" + ffunix + ffxx;
    document.write('<scr'+'ipt src="'+location.protocol+'//as.nn.impact-ad.jp/jserver/CCID=1/ZID=' + testsession + '/FT=1">'+'</scr'+'ipt>');
  }
}else{
  ffxx = Math.floor(Math.random() * 1000);
  if(ffxx<100){
    ffxx = "0"+ffxx;
  }
  if(ffxx<10){
    ffxx = "0"+ffxx;
  }
  ffxx+="";

  var ffunix=new Date/1e3|0;

  var testsession = "9" + ffunix + ffxx;
  document.write('<scr'+'ipt src="'+location.protocol+'//as.nn.impact-ad.jp/jserver/CCID=1/ZID=' + testsession + '/FT=0">'+'</scr'+'ipt>');
}
