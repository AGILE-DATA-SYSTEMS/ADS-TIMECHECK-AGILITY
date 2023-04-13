/**
 * Copyright 2006-2010 MARS FLAG Corporation. All rights reserved.
 *
 * http://www.marsflag.com/
 */
function initJSONPSuggest(G,O){O=O||window.jQuery;if(!window.GALFSRAM){window.GALFSRAM={}}var E=G.interface_url||"suggest.x";var b=G.handler_name||"parent.suggest_ctxt";var N=G.callback||"load_suggest";var U=G.selected_bgcolor||"#ddd";var F=G.max||10;var H=G.array_styles||[];var d=G.input_jquery;var Y=G.suggest_frame||"suggest_frame";var L=G.no_result_mess||"";var Q=G.array_queries;var M=G.show_data_graph;var f="suggest_area";var a=G.to_upper;var A=G.debug;var I=G.mode;var h="inside";if(G.suggest_type){h=G.suggest_type}var T;var W=navigator.userAgent;var J="";if(E!="suggest.x"){J="http://"+E.split("/")[2]}var V=function(AO){if(T){return }try{AO=AO||window.event;if(AO&&AO.type=="readystatechange"&&this.readyState!="complete"){return }if(X){clearInterval(X)}T=true;if(!(e||S)){C.onload=C.onreadystatechange=null}var j=C.contentWindow||window.frames[Y];var r=j.document;var v=false;var k=H.join("")+(M?"":".suggest_data_graph {display:none}");if(e||S){r.body.innerHTML="";if(H){var y=r.createElement("style");y.type="text/css";if(S){y.styleSheet.cssText=k}else{y.innerHTML=k}r.body.appendChild(y)}var i=r.createElement("div");i.id=f;r.body.appendChild(i)}else{if(H){r.write('<style type="text/css"><!-- '+k+"--></style>")}r.write('<body><div id="'+f+'"></div></body>');r.close();var i=r.getElementById(f)}r.body.scroll="no";var x=function(){var AS=d.css("font-size");var AU=d.css("font-family");var AT=d.css("height");var AV=r.styleSheets&&r.styleSheets[0];if(AV.addRule){AV.addRule("body *","font-size:"+AS+" !important");AV.addRule("body *","font-family:"+AU+" !important");AV.addRule("#suggest_area td","height:"+AT+" !important")}else{AV.insertRule("body * {font-size:"+AS+"}",AV.cssRules.length);AV.insertRule("body * {font-family:"+AU+"}",AV.cssRules.length);AV.insertRule("#suggest_area td {height:"+AT+" !important}",AV.cssRules.length)}};x();i.onselectstart=i.oncontextmenu=function(){return false};var AE="suggest_data_";var AB=b;var AA=AB.replace(/^[^.]*\.(.*)$/,"$1");if(!GALFSRAM[AA]){GALFSRAM[AA]={}}var AM=function(){P.css("visibility","visible")};var s=function(){P.css("visibility","hidden")};var AN=function(AS,AT){if(!arguments.length){var AU=r.getElementsByTagName("TABLE")[0];AS=AU.offsetWidth;AT=AU.offsetHeight;if(D){AS+=3;AT++}}C.style.width=AS+"px";C.style.height=AT+"px"};GALFSRAM[AA]["resize_suggest"]=AN;var z=function(){return P.css("visibility")=="visible"};var w=function(AS){return r.getElementById(AS)};var AR=window.onresize;window.onresize=function(){m();if(AR){AR()}};var m=function(){var AW=d[0];var AX=YAHOO.util.Dom.getXY(AW);if(h=="inside"){C.style.left=(AX[0]-(S?2:0))+"px"}else{var AT=0;if(R){AT=1}if(window.location.hostname.match("^search2.nissan-global.com")&&S){AT=-18}var AU=document.getElementById("MF_form_phrase");var AV=AU.getBoundingClientRect();var AS=GALFSRAM.jQuery("body").width();C.style.right=(AS-AV.right+AT)+"px"}C.style.top=(AX[1]+AW.offsetHeight-(S?2:0))+"px";C.style.width=AW.offsetWidth+"px"};GALFSRAM[N]=function(AS){v=false;if(!AS||AS.length==0){if(!L){return }v=true}if(a){for(var AU=0;AU<AS.length;AU++){AS[AU].word=AS[AU].word.toUpperCase()}}m();if(!d.val()){return }var AT={prefix:AE,handler:AB,handler:"parent.GALFSRAM."+AA,data:AS};if(v){AT.data=[{word:L,point:-1}]}try{suggest_tmpl(AT,i);setTimeout("GALFSRAM."+AA+"['resize_suggest']()",0);o=AS;AK=-1;AM()}catch(AV){if(A){alert(c(AV))}}};var AH=function(AS){if(AS.match(/^\s*$/)){return false}var AU;if(I!=""){AU=["callback=GALFSRAM."+N,"q="+encodeURIComponent(AS),"ie=utf8","max="+F,"mode="+I,"d="+(+new Date)]}else{AU=["callback=GALFSRAM."+N,"q="+encodeURIComponent(AS),"ie=utf8","max="+F,"d="+(+new Date)]}if(Q){AU=AU.concat(Q)}var AT=E+"?"+AU.join("&");jsonp.load("jsonp_suggest",AT,"UTF-8");return AT};var AJ=d.val();var o=[];var AK=-1;var AG=function(AS){if(typeof AS!="undefined"){AI();AK=AS}if(o[AK]){var AT=w(AE+AK);AT.style.backgroundImage="url("+J+"/site/img/search_pulldown01_on.gif)"}};GALFSRAM[AA]["focus"]=AG;var AI=function(){if(o[AK]){var AS=w(AE+AK);AS.style.backgroundImage="url("+J+"/site/img/search_pulldown01_off.gif)"}};var AQ=function(){if(AK<0){AK=0}else{AI();AK++}if(AK>=o.length){AK=-1;return }AG()};var u=function(){if(AK<0){AK=o.length-1}else{AI();AK--;if(AK==-1){return }}AG()};var AP=function(){var AS=o[AK];if(AS){if(d.val()!=AS.word){d.val(AS.word);AJ=AS.word;AH(AS.word+" ");return false}}return true};var AD;GALFSRAM[AA]["suggest_mousedown"]=function(AS){if(v){return }AD=(new Date()).getTime()};GALFSRAM[AA]["suggest_click"]=function(AS){if(v){return false}if(AP()){d[0].form.submit()}else{d[0].focus();return false}};var l={"9":"tab","16":"shift","17":"ctl","27":"esc","18":"alt","19":"pause/break","20":"caps lock","33":"pageup","34":"pagedown","35":"end","36":"home","37":"left","38":"up","40":"down","44":"print screen","45":"ins"};var AC=false;var AF=function(AT){var AS=AT.keyCode;AC=AT.shiftKey;if(AS==13&&AK!=-1){return false}if(l[AS]){return false}return true};var t=function(){var AS=d.val();if(AJ==AS){return }AJ=AS;if(AS==""){o=[];s()}else{AH(AS)}};var n;var q=function(){if(!n){n=setInterval(t,100)}};var p=function(){if(!n){return }clearInterval(n);n=null};var AL={keyup:function(AS){(AF(AS)!=false)&&t()},keypress:function(AS){(AF(AS)!=false)&&q()},keydown:function(AT){var AS=AT.keyCode;AC=AT.shiftKey;switch(AS){case 9:if(!z()){return true}if(AC){u()}else{AQ()}break;case 40:AQ();break;case 38:u();break;case 27:s();break;case 13:if(!AP()){break}default:if(W.indexOf("Gecko")>=0){(AF(AT)!=false)&&q()}return }return false},blur:function(AT){var AS=(new Date()).getTime();if(AD+100>AS){return }p();s()},focus:function(AS){if(o.length==0&&!v){return }AM()}};if(window.opera||(W.indexOf("Gecko")>=0&&W.indexOf("KHTML")==-1)){d.keypress(AL.keypress)}else{d.keyup(AL.keyup)}d.keydown(AL.keydown).blur(AL.blur).focus(AL.focus)}catch(AO){if(A){alert(c(AO))}}};var c=function(l){var i,j=[];for(i in l){j[j.length]=i+" :\t"+l[i]}return j.join("\n")};var X;var D=W.match(/AppleWebKit\/4\d\d/);var e=W.match(/Opera/);var S=W.match(/MSIE/);var R=W.match(/MSIE 6/);var Z=W.match(/(iPhone|iPad|iPod|Android|dream|CUPCAKE|blackberry|webOS|incognito|webmate)/);var K=W.match(/Firefox/);var g=R?"javascript:false;":"about:blank";if(typeof (d)=="string"){d=O(d)}if(!d||!d[0]){return }d.attr("autocomplete","off");var P=O("#"+Y);var C=P.get(0);var B=false;if(P.length==0){C=document.createElement("IFRAME");P=O(C);B=true}C.name=C.id=Y;C.frameBorder=0;C.scrolling="no";P.css({position:"absolute",visibility:"hidden",zIndex:10000,top:"0px",height:"0px",width:d[0].offsetWidth+"px",border:"0px"});if(!B){P.css("display","block")}if(B){O(document.body).append(C)}else{P.prependTo(O(document.body))}if(!(e||S)){C.onload=C.onreadystatechange=V;C.src=g}if(D||e||S){X=setInterval(V,100)}};