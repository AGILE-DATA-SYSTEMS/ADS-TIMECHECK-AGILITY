/**
 * Copyright 2006-2010 MARS FLAG Corporation. All rights reserved.
 *
 * http://www.marsflag.com/
 */
(function(A){window[A[A.length-1].src.replace(/.*#/,"")]=function(B,D){if(B==undefined){B={}}try{var C=[];C.p=C.push;var G=B.prefix;var I=B.handler;var E=B.data;C.p('<table cellpadding="0" cellspacing="0" border="0" width="100%">\n');if(E&&E.length){for(var F=0;F<E.length;F++){C.p('<tr class="suggest_row_');C.p(F%2);C.p('"\n\tid="');C.p(G);C.p(F);C.p('"\n\tonmouseover="try{');C.p(I);C.p(".focus(");C.p(F);C.p(');}catch(e){}"\n\tonmousedown="try{');C.p(I);C.p('.suggest_mousedown(event);}catch(e){}"\n\tonclick="try{');C.p(I);C.p('.suggest_click(event);}catch(e){}"\n\n><td align="left"\n\tclass="suggest_data_word"\n\tstyle="\n\t\tpadding-left: 2px;\n\t"\n\tnowrap\n>');C.p(E[F].word);C.p("</td>\n</tr>\n")}}C.p("</table>\n")}catch(H){return{exception:H,message:"An exception occurred while excuting template. Error type: "+H.name+". Error message: "+H.message}}var J=C.join("");if(typeof D!="undefined"){if(typeof D=="string"){D=document.getElementById(D)}D.innerHTML=J}return J}})(document.getElementsByTagName("script"));