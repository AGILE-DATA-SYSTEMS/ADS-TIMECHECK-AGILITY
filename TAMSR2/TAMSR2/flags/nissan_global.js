//2013/1/31 ver1.08

var SC_global_URL=location.href;
SC_global_URL=SC_global_URL.split("/");

document.write('<SCR' + 'IPT language="JavaScript" type="text/javascript" charset="utf-8" src="'+location.protocol+'//a248.e.akamai.net/f/248/45380/20m/dac1.download.akamai.com/45379/sr/js/id.js"></SCR' + 'IPT>');

if(location.href.indexOf("/TECHNOLOGY/MAGAZINE/") > -1){
  document.write('<SCR' + 'IPT language="JavaScript" type="text/javascript" charset="utf-8" src="' + location.protocol + '//a248.e.akamai.net/f/248/45380/20m/dac1.download.akamai.com/45379/sr/js/nissan_global_ntj.js"></SCR' + 'IPT>');
}else if(location.href.indexOf("search2.nissan-global.com") > -1){
  document.write('<SCR' + 'IPT language="JavaScript" type="text/javascript" charset="utf-8" src="' + location.protocol + '//a248.e.akamai.net/f/248/45380/20m/dac1.download.akamai.com/45379/sr/js/nissan_global_utf.js"></SCR' + 'IPT>');
}else if(SC_global_URL[3]=="JP"){
  document.write('<SCR' + 'IPT language="JavaScript" type="text/javascript" charset="Shift_JIS" src="' + location.protocol + '//a248.e.akamai.net/f/248/45380/20m/dac1.download.akamai.com/45379/sr/js/nissan_global_sjis.js"></SCR' + 'IPT>');
}else{
  document.write('<SCR' + 'IPT language="JavaScript" type="text/javascript" charset="iso-8859-1" src="' + location.protocol + '//a248.e.akamai.net/f/248/45380/20m/dac1.download.akamai.com/45379/sr/js/nissan_global_eu.js"></SCR' + 'IPT>');
}
