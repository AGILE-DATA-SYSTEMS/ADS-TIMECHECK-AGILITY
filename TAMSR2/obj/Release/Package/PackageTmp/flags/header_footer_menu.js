// ***************************************************************
// header_footer_menu (COMMON ver.) 12/10/14 relative and absolute
// ***************************************************************
//
// var disableDynamicHeaderFlag			="off";		="on";
// var enableDynamicSimpleHeaderFlag	="off";		="on";
// var disableGlobalMenuFlag			="off";		="on";
// var disableHeaderLineMenuFlag		="off";		="on";
// var disableSearchBoxFlag				="off";		="on";
// var absoluteFlag						="off";		="on";
// var commonFooterMenuFlag				="off";
// var charsetFlag						="SJIS"
//

var path02=window.location.pathname;
//var path02='/EN/COMPANY/NEWSRELEASE/';	// test path
if((path02.match(".html$")==null)&&(path02.match(".jsp$")==null)){
	path02=path02+'index.html';				// add file type
}
var path03=window.location.hostname;
//path03='search.nissan-global.com';		//test hostname

if(typeof(disableDynamicHeaderFlag)=="undefined"){var disableDynamicHeaderFlag="off";}
if(typeof(enableDynamicSimpleHeaderFlag)=="undefined"){var enableDynamicSimpleHeaderFlag="off";}
if(typeof(disableGlobalMenuFlag)=="undefined"){var disableGlobalMenuFlag="off";}
if(typeof(disableHeaderLineMenuFlag)=="undefined"){var disableHeaderLineMenuFlag="off";}
if(typeof(absoluteFlag)=="undefined"){var absoluteFlag="off";}
if(typeof(disableSearchBoxFlag)=="undefined"){var disableSearchBoxFlag="off";}
if(typeof(YEARS80Flag)=="undefined"){var YEARS80Flag="on";}/* YEARS80 */
if(typeof(charsetFlag)=="undefined"){var charsetFlag="SJIS";}

var disableDynamicHeader=new Array(
	// disable Dynamic Header Menu path
	'/EN/110311.html',
	'/EN/REPORT/110415.html'//,
//	'/EN/DESIGN/RECRUIT/',
//	'/CN/DESIGN/RECRUIT/',
//	'/EN/BLUECITIZENSHIP/'
);
for(var s=0;s<disableDynamicHeader.length;s++){
	if(path02.match(disableDynamicHeader[s])!=null){
		disableDynamicHeaderFlag="on";
	}
}

var enableDynamicSimpleHeader=new Array(
	// enable Dynamic Simple Header Menu path (conflict FLASH) exp. technology
	//'/EN/COMPANY/NEWSRELEASE/'
);
for(var s=0;s<enableDynamicSimpleHeader.length;s++){
	if(path02.match(enableDynamicSimpleHeader[s])!=null){
		enableDynamicSimpleHeaderFlag="on";
	}
}

if((path02.match("^/nissan/en/stock_performance_en.jsp")!=null)||(path03.match("^search.nissan-global.com")!=null)||(path03.match("^search2.nissan-global.com")!=null)){
	absoluteFlag="on";
}
if((path03.match("^reports.nissan-global.com")!=null)||(path03.match("^test.reports.nissan-global.com")!=null)){
	absoluteFlag="on";
	commonFooterMenuFlag="off";
	charsetFlag="UTF8";
}
if((path03.match("^photos.nissan-global.com")!=null)||(path03.match("^test.photos.nissan-global.com")!=null)){
	absoluteFlag="on";
	commonFooterMenuFlag="off";
	charsetFlag="UTF8";
}
if((path03.match("^blog.nissan-global.com")!=null)||(path03.match("^test.blog.nissan-global.com")!=null)){
	absoluteFlag="on";
	commonFooterMenuFlag="off";
	charsetFlag="UTF8";
}
if((path03.match("^www.nissan360blog.com")!=null)){
	absoluteFlag="on";
	commonFooterMenuFlag="off";
	charsetFlag="UTF8";
}
/*reports (old)*/
if(path02.match("/EN/REPORTS/2011/[0-9][0-9]/")!=null){
	if(path02.match("index.html")==null){
		disableHeaderLineMenuFlag="on";
		disableSearchBoxFlag="on";
		disableGlobalMenuFlag="on";
		commonFooterMenuFlag="off";
		YEARS80Flag='off';/* YEARS80 */
	}
}
/* design recruit & bc */
if((path02.match("/EN/DESIGN/RECRUIT/")!=null)||(path02.match("/CN/DESIGN/RECRUIT/")!=null)||(path02.match("/EN/BLUECITIZENSHIP/")!=null)){
	disableHeaderLineMenuFlag="on";
	disableSearchBoxFlag="on";
	disableGlobalMenuFlag="on";
	commonFooterMenuFlag="off";
	YEARS80Flag='off';/* YEARS80 */
}
//YEARS80
if(
	(path02.match("/EN/NRC/")!=null)
){
		YEARS80Flag='off';
}

var root_uri01="";
if(absoluteFlag=="on"){
	 root_uri01="http://www.nissan-global.com";
}

var writeDynamicHeader00='';
var writeDynamicHeader01='';
var writeDynamicHeader02='';
var writeDynamicHeader03='';
var writeDynamicHeader04='';
var writeDynamicHeader05='';
var writeDynamicHeader06='';
var writeDynamicHeader07='';
var writeDynamicHeader08='';
var writeDynamicHeader09='';
var writeDynamicHeader10='';
var writeDynamicHeader11='';

if(disableDynamicHeaderFlag=='off'){
	//$('div#header').empty();
	writeDynamicHeader01+='<p id="ci-nissan"><a href="'+root_uri01+'/EN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/logo_nmc.gif" alt="NISSAN GLOBAL TOP" width="192" height="50" /></a></p>';
	/* YEARS80 */
	if(YEARS80Flag=='on'){
		writeDynamicHeader01+='<p id="years80"><a href="'+root_uri01+'/EN/HERITAGE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/nissan_80_years.gif" alt="80 years of moving people" width="173" height="45" /></a></p>';
	}
	if(disableHeaderLineMenuFlag=='off'){
		writeDynamicHeader02+='<ul id="utilityNav">';
		writeDynamicHeader02+='<li><a href="'+root_uri01+'/EN/GLOBAL/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/un_global-websites.gif" alt="NISSAN WORLDWIDE" width="112" height="12" /></a></li>';
		writeDynamicHeader02+='<li><a href="'+root_uri01+'/JP/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/un_japanese.gif" alt="Japanese" width="30" height="12" /></a></li>';
		writeDynamicHeader02+='</ul>';
	}
	if(disableSearchBoxFlag=='off'){
		writeDynamicHeader03+='<form method="get" action="http://search2.nissan-global.com/en_global/search.x">';
		writeDynamicHeader03+='<fieldset>';
		writeDynamicHeader03+='<p><input type="text" name="q" maxlength="256" value="" id="MF_form_phrase" 00id="searchBox" autocomplete="off" /> <input type="image" src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/btn_search.gif" alt="GO" id="searchBtn" /><input type="hidden" name="ie" value="UTF8"><input type="hidden" name="page" value="1"></p>';
		writeDynamicHeader03+='</fieldset>';
		writeDynamicHeader03+='</form>';
	}
	if(disableGlobalMenuFlag=='off'){
		writeDynamicHeader04+='<ul id="globalNav">';
		//writeDynamicHeader05+='<li id="gnCompany"><a href="'+root_uri01+'/EN/COMPANY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_company03.gif" alt="OUR COMPANY" width="117" height="13" /></a>';
		writeDynamicHeader05+='<li id="gnCompany"><a href="'+root_uri01+'/EN/COMPANY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/gn_company03.gif" alt="OUR COMPANY" width="90" height="8" /></a>';
		if(enableDynamicSimpleHeaderFlag=='off'){
			writeDynamicHeader05+='<ul>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/COMPANY/MESSAGE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_vision_o.gif" alt="Message/Vision" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_outline_o.gif" alt="Outline of Company" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/HERITAGE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_heritage_o.gif" alt="Nissan Heritage" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/COMPANY/DIVERSITY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_diversity_o.gif" alt="Diversity" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/ALLIANCE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_renault_o.gif" alt="Renault-Nissan Alliance" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/COMPANY/RECRUIT/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_recruit_o.gif" alt="Career" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/COMPANY/LIBRARY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_library_o.gif" alt="Company Information Library" width="180" height="26" /></a></li>';
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/CONSULTING/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_consulting_o.gif" alt="NISSAN CONSULTING" width="180" height="26" /></a></li>';//
			writeDynamicHeader05+='<li><a href="'+root_uri01+'/EN/LICENSE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_com_license_o.gif" alt="Licensing Business" width="180" height="26" /></a></li>';//
			writeDynamicHeader05+='</ul>';
		}
		writeDynamicHeader05+='</li>';
		//writeDynamicHeader06+='<li id="gnProducts"><a href="'+root_uri01+'/EN/PRODUCTS/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_products03.gif" alt="PRODUCTS" width="94" height="13" /></a>';
		writeDynamicHeader06+='<li id="gnProducts"><a href="'+root_uri01+'/EN/PRODUCTS/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/gn_products03.gif" alt="PRODUCTS" width="71" height="8" /></a>';
		if(enableDynamicSimpleHeaderFlag=='off'){
			writeDynamicHeader06+='<ul>';
			writeDynamicHeader06+='<li><a href="'+root_uri01+'/EN/NISSAN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_products_nissan_o.gif" alt="Nissan" width="151" height="26" /></a></li>';
			writeDynamicHeader06+='<li><a href="'+root_uri01+'/EN/INFINITI/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_products_infiniti_o.gif" alt="Infiniti" width="151" height="26" /></a></li>';
			writeDynamicHeader06+='<li><a href="'+root_uri01+'/EN/DATSUN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_products_datsun_o.gif" alt="Datsun" width="151" height="26" /></a></li>';

			//writeDynamicHeader06+='<li><a href="http://www.nissanlcv.com/EN/" target="_blank"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_products_lcv_o.gif" alt="LCV (Light Commercial Vehicle)" width="151" height="26" /></a></li>';
			writeDynamicHeader06+='<li><a href="http://www.nissanmarine.com/" target="_blank"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_products_marine_o.gif" alt="Marine" width="151" height="26" /></a></li>';
			writeDynamicHeader06+='</ul>';
		}
		writeDynamicHeader06+='</li>';
		//writeDynamicHeader07+='<li id="gnNews"><a href="'+root_uri01+'/EN/NEWS/index2.html"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news03.gif" alt="NEWS & EVENTS" width="124" height="13" /></a>';
		writeDynamicHeader07+='<li id="gnNews"><a href="'+root_uri01+'/EN/NEWS/index2.html"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/gn_news03.gif" alt="NEWS & EVENTS" width="96" height="8" /></a>';
		if(enableDynamicSimpleHeaderFlag=='off'){
			writeDynamicHeader07+='<ul>';
			writeDynamicHeader07+='<li><a href="'+root_uri01+'/EN/NEWS/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_release_o.gif" alt="News Releases" width="151" height="26" /></a></li>';
			writeDynamicHeader07+='<li><a href="http://reports.nissan-global.com/EN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_report_o.gif" alt="Reports" width="151" height="26" /></a></li>';
			writeDynamicHeader07+='<li><a href="http://photos.nissan-global.com/EN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_photo_o.gif" alt="Nissan Photo Gallery" width="151" height="26" /></a></li>';
			writeDynamicHeader07+='<li><a href="http://blog.nissan-global.com/EN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_blog_o.gif" alt="Nissan Channel 23 Blog" width="151" height="26" /></a></li>';
			writeDynamicHeader07+='<li><a href="'+root_uri01+'/EN/NISSANCHANNEL/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_channel_o.gif" alt="Nissan Channel 23 TV" width="151" height="26" /></a></li>';
			writeDynamicHeader07+='<li><a href="http://www.nissan-motorsports.com/ENN/" target="_blank"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_sports_o.gif" alt="Motorsports" width="151" height="26" /></a></li>';
			writeDynamicHeader07+='<li><a href="'+root_uri01+'/EN/MOTORSHOW/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_news_event_show_o.gif" alt="Motor Show" width="151" height="26" /></a></li>';//
			writeDynamicHeader07+='</ul>';
		}
		writeDynamicHeader07+='</li>';
		//writeDynamicHeader08+='<li id="gnEnvironment"><a href="'+root_uri01+'/EN/SOCIALCONTRIBUTION/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_csr03.gif" alt="SUSTAINABILITY" width="124" height="13" /></a>';
		writeDynamicHeader08+='<li id="gnEnvironment"><a href="'+root_uri01+'/EN/SOCIALCONTRIBUTION/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/gn_csr03.gif" alt="SUSTAINABILITY" width="96" height="8" /></a>';
		if(enableDynamicSimpleHeaderFlag=='off'){
			writeDynamicHeader08+='<ul>';
			writeDynamicHeader08+='<li><a href="'+root_uri01+'/EN/CSR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_csr_csr_o.gif" alt="CSR" width="151" height="26" /></a></li>';
			writeDynamicHeader08+='<li><a href="'+root_uri01+'/EN/ENVIRONMENT/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_csr_env_o.gif" alt="Environment" width="151" height="26" /></a></li>';
			writeDynamicHeader08+='<li><a href="http://www.nissan-zeroemission.com/EN/" target="_blank"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_csr_zev_o.gif" alt="Zero Emission" width="151" height="26" /></a></li>';
			writeDynamicHeader08+='<li><a href="'+root_uri01+'/EN/SAFETY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_csr_safety_o.gif" alt="Safety" width="151" height="26" /></a></li>';
			writeDynamicHeader08+='<li><a href="'+root_uri01+'/EN/CITIZENSHIP/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_csr_society_o.gif" alt="Corporate Citizenship" width="151" height="26" /></a></li>';


			writeDynamicHeader08+='</ul>';
		}
		writeDynamicHeader08+='</li>';
		//writeDynamicHeader09+='<li id="gnCreate"><a href="'+root_uri01+'/EN/NISSANCRAFTSMANSHIP/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_create03.gif" alt="CRAFTSMANSHIP" width="130" height="13" /></a>';
		writeDynamicHeader09+='<li id="gnCreate"><a href="'+root_uri01+'/EN/NISSANCRAFTSMANSHIP/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/gn_create03.gif" alt="CRAFTSMANSHIP" width="101" height="8" /></a>';
		if(enableDynamicSimpleHeaderFlag=='off'){
			writeDynamicHeader09+='<ul>';
			writeDynamicHeader09+='<li><a href="'+root_uri01+'/EN/TECHNOLOGY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_cre_technology_o.gif" alt="Technology" width="151" height="26" /></a></li>';
			writeDynamicHeader09+='<li><a href="'+root_uri01+'/EN/DESIGN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_cre_design_o.gif" alt="Design" width="151" height="26" /></a></li>';
			writeDynamicHeader09+='<li><a href="'+root_uri01+'/EN/QUALITY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_cre_quality_o.gif" alt="Quality" width="151" height="26" /></a></li>';
			writeDynamicHeader09+='</ul>';
		}
		writeDynamicHeader09+='</li>';
		//writeDynamicHeader10+='<li id="gnIR"><a href="'+root_uri01+'/EN/IR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn_ir03.gif" alt="FOR INVESTORS" width="123" height="13" /></a>';
		writeDynamicHeader10+='<li id="gnIR"><a href="'+root_uri01+'/EN/IR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/YEARS80/gn_ir03.gif" alt="FOR INVESTORS" width="94" height="8" /></a>';
		if(enableDynamicSimpleHeaderFlag=='off'){
			writeDynamicHeader10+='<ul>';

			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/MESSAGE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_message_o.gif" alt="Message from the CEO" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/NEWS/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_news_o.gif" alt="News" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_individual_o.gif" alt="For Individual Investors" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/MIDTERMPLAN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_plan_o.gif" alt="Mid-term Plan" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/FINANCIAL/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_financial_o.gif" alt="Financial Announcements" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_library_o.gif" alt="IR Library" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/EVENT/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_events_o.gif" alt="IR Events" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/INSIDE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_inside_o.gif" alt="Inside NISSAN" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="http://www.bloomberg.com/quote/7201:JP" onClick="s.pageName=\'CL:EN:IR:StockQuote\'; s.prop10=\'CL:EN:IR:StockQuote\'; s.prop11=\'For Investors\'; s.prop12=\'EN\'; s.t();" target="_blank"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_quote_o.gif" alt="Stock Quote" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/STOCK/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_stock_o.gif" alt="Stock Information" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/SHAREHOLDER/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_shareholder_o.gif" alt="Shareholders Meeting" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/CALENDAR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_calendar_o.gif" alt="IR Calendar" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/RANK/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_ratings_o.gif" alt="Ratings Information" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/CORPORATEBOND/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_bond_o.gif" alt="Bond Information" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/FAQ/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_faq_o.gif" alt="Frequently Asked Questions (FAQ)" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/INQUIRY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_inquiry_o.gif" alt="Inquiry / Link" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='<li><a href="'+root_uri01+'/EN/IR/DISCLAIMER/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/HEADER/gn02_ir_disclaimer_o.gif" alt="Disclaimer" width="151" height="26" /></a></li>';
			writeDynamicHeader10+='</ul>';
		}
		writeDynamicHeader10+='</li>';
		writeDynamicHeader11+='</ul>';
	}
	writeDynamicHeader11+='<hr />';

	writeDynamicHeader00=writeDynamicHeader01+writeDynamicHeader02+writeDynamicHeader03+writeDynamicHeader04+writeDynamicHeader05+writeDynamicHeader06+writeDynamicHeader07+writeDynamicHeader08+writeDynamicHeader09+writeDynamicHeader10+writeDynamicHeader11;
}

//footer_menu01
var footer_menu00='';
var footer_menu01='';
var footer_menu02='';
var footer_menu03='';
var footer_menu04='';

if((path02.match("/EN/IR/")!=null)){
	//ir
footer_menu01+='<div id="footer-menu" class="clearfix">';
footer_menu01+='<div style="padding:12px 20px 4px 7px;"><h3 style="margin-bottom:0;"><a href="'+root_uri01+'/EN/IR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu00.gif" alt="For Investors TOP"></a></h3></div>';
footer_menu01+='<!--box00--><div id="box00"></div>';
footer_menu01+='<!--box01--><div id="box01" style="width:232px;"><div id="box012" style="width:207px;">';
footer_menu01+='<h3><a href="'+root_uri01+'/EN/IR/MESSAGE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu11.gif" alt="Message from CEO"></a></h3>';
footer_menu01+='<h3><a href="'+root_uri01+'/EN/IR/NEWS/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu12.gif" alt="News"></a></h3>';
footer_menu01+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/NEWSRELEASE/"><span>News Release</span></a>';
footer_menu01+='<ul>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/NEWSRELEASE/2013/"><span>2013</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/NEWSRELEASE/2012/"><span>2012</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/NEWSRELEASE/2011/"><span>2011</span></a></li>';
footer_menu01+='</ul></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/NISSANCHANNEL/"><span>Nissan Channnel 23 TV</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/TSE/"><span>TSE Filings</span></a>';
footer_menu01+='<ul>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/TSE/2013/"><span>2013</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/TSE/2012/"><span>2012</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/NEWS/TSE/2011/"><span>2011</span></a></li>';
footer_menu01+='</ul></li>';
footer_menu01+='</ul>';
footer_menu01+='<h3><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu13.gif" alt="For Individual Investors"></a></h3>';
footer_menu01+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/MIDTERMPLAN/"><span>Mid-term Plan</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/MIDTERMPLAN/HISTORY/"><span>Nissan Mid-term Plan History</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/RESULTS/"><span>Financial Highlights</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/LATESTSALES/"><span>Monthly Sales Results</span></a>';
footer_menu01+='<ul>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/LATESTSALES/2013/"><span>2013</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/LATESTSALES/2012/"><span>2012</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/LATESTSALES/2011/"><span>2011</span></a></li>';
footer_menu01+='</ul></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/STOCK/"><span>Stock Information</span></a></li>';
footer_menu01+='</ul>';
footer_menu01+='<h3><a href="'+root_uri01+'/EN/IR/MIDTERMPLAN/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu28.gif" alt="Mid-term Plan"></a></h3>';
footer_menu01+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu01+='<li><a href="'+root_uri01+'/EN/IR/MIDTERMPLAN/HISTORY/"><span>Nissan Mid-term Plan History</span></a></li>';
footer_menu01+='</ul></div></div>';

footer_menu02+='<!--box02-->';
footer_menu02+='<div id="box02" style="width:232px;"><div id="box022" style="width:207px;">';
footer_menu02+='<!--02-->';
footer_menu02+='<h3><a href="'+root_uri01+'/EN/IR/FINANCIAL/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu14.gif" alt="Financial Announcements"></a></h3>';
footer_menu02+='<h3><a href="'+root_uri01+'/EN/IR/LIBRARY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu15.gif" alt="IR Library"></a></h3>';
footer_menu02+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/YEARS/"><span>IR Archive</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FINANCIAL/"><span>Financial Results Material</span></a>';
footer_menu02+='<ul>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FINANCIAL/2013/"><span>2013</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FINANCIAL/2012/"><span>2012</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FINANCIAL/2011/"><span>2011</span></a></li>';
footer_menu02+='</ul></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/AR/"><span>Annual Report</span></a>';
footer_menu02+='<ul>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/AR/2013/"><span>2013</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/AR/2012/"><span>2012</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/AR/2011/"><span>2011</span></a></li>';
footer_menu02+='</ul></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FR/"><span>Financial Information (Yukashoken-Hokokusho)</span></a>';
footer_menu02+='<ul>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FR/2013/"><span>2013</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FR/2012/"><span>2012</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/FR/2011/"><span>2011</span></a></li>';
footer_menu02+='</ul></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/BUSINESS/"><span>Business Reports</span></a>';
footer_menu02+='<ul>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/BUSINESS/2009/"><span>2009</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/BUSINESS/2008/"><span>2008</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/BUSINESS/2007/"><span>2007</span></a></li>';
footer_menu02+='</ul></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/PROFILE/"><span>Profile</span></a>';
footer_menu02+='<ul>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/PF/2012/"><span>Profile 2012</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/PF/2011/"><span>Profile 2011</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/PF/2010/"><span>Profile 2010</span></a></li>';
footer_menu02+='<li style="background:none;">&nbsp;</li>';
footer_menu02+='</ul></li>';
footer_menu02+='</ul></div></div>';

footer_menu03+='<!--box03-->';
footer_menu03+='<div id="box03" style="width:232px;"><div id="box032" style="width:207px;">';
footer_menu03+='<h3><a href="'+root_uri01+'/EN/IR/EVENT/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu16.gif" alt="IR Events"></a></h3>';
footer_menu03+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/EVENT/2012/"><span>2012</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/EVENT/2011/"><span>2011</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/EVENT/2010/"><span>2010</span></a></li>';
footer_menu03+='</ul>';
footer_menu03+='<h3><a href="'+root_uri01+'/EN/IR/INSIDE/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu17.gif" alt="Inside NISSAN"></a></h3>';
footer_menu03+='<h3><a href="http://www.bloomberg.com/quote/7201:JP" onClick="s.pageName=\'CL:EN:IR:StockQuote\'; s.prop10=\'CL:EN:IR:StockQuote\'; s.prop11=\'For Investors\'; s.prop12=\'EN\'; s.t();" target="_blank"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu18.gif" alt="Stock Quote"></a></h3>';
footer_menu03+='<h3><a href="'+root_uri01+'/EN/IR/STOCK/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu19.gif" alt="Stock Information"></a></h3>';
footer_menu03+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/STOCK/DIVIDEND/"><span>Previous Dividend Payments</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/STOCK/SERVICES/"><span>Shareholder Services</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/STOCK/INFORMATION/"><span>Nissan\'s Stock Information</span></a></li>';
footer_menu03+='</ul>';
footer_menu03+='<h3><a href="'+root_uri01+'/EN/IR/SHAREHOLDER/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu20.gif" alt="Shareholders Meeting"></a></h3>';
footer_menu03+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/SHAREHOLDER/114_index.html"><span>114th Shareholders Meeting</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/SHAREHOLDER/113_index.html"><span>113th Shareholders Meeting</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/IR/SHAREHOLDER/112_index.html"><span>112th Shareholders Meeting</span></a></li>';
footer_menu03+='</ul>';
footer_menu03+='<h3><a href="'+root_uri01+'/EN/IR/CALENDAR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu21.gif" alt="IR Calendar"></a></h3>';
footer_menu03+='<h3><a href="'+root_uri01+'/EN/IR/RANK/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu22.gif" alt="Ratings Information"></a></h3>';
footer_menu03+='</div></div>';

footer_menu04+='<!--box04-->';
footer_menu04+='<div id="box04" style="width:207px;"><div id="box042" style="width:207px;">';
footer_menu04+='<h3><a href="'+root_uri01+'/EN/IR/CORPORATEBOND/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu23.gif" alt="Bond Information"></a></h3>';
footer_menu04+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/CORPORATEBOND/PLAN/"><span>Financial Plan</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/CORPORATEBOND/SALES/"><span>Sales Finance Company</span></a></li>';
footer_menu04+='</ul>';
footer_menu04+='<h3><a href="'+root_uri01+'/EN/IR/FAQ/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu24.gif" alt="Frequently Asked Questions (FAQ)"></a></h3>';
footer_menu04+='<ul class="linkList01" style="margin-bottom:0.5em;">';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FAQ/STOCK/"><span>About Stock</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FAQ/SHAREHOLDER/"><span>About Shareholders Meeting</span></a></li>';
//footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FAQ/DIVIDEND/"><span>About Dividend</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FAQ/CLOSING/"><span>About Closing</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FAQ/NISSAN/"><span>About Nissan</span></a></li>';
footer_menu04+='</ul>';
footer_menu04+='<h3><a href="'+root_uri01+'/EN/IR/INQUIRY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu25.gif" alt="Inquiry / Link"></a></h3>';
footer_menu04+='<h3><a href="'+root_uri01+'/EN/IR/DISCLAIMER/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu26.gif" alt="Disclaimer"></a></h3>';
footer_menu04+='</div></div>';
footer_menu04+='</div>';
}else{
//other
footer_menu01+='<!--footer-menu--><div id="footer-menu" class="clearfix"><!--box00--><div id="box00"></div>';

footer_menu01+='<!--box01--><div id="box01"><div id="box012">';
footer_menu01+='<h3><a href="'+root_uri01+'/EN/COMPANY/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu01.gif" alt="OUR COMPANY" /></a></h3>';
footer_menu01+='<ul class="linkList01">';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/MESSAGE/"><span>Message/Vision</span></a>';
footer_menu01+='<ul>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/MESSAGE/MESSAGE/"><span>Message</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/MESSAGE/VISION/"><span>Vision&Mission</span></a></li>';
footer_menu01+='</ul></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/"><span>Outline of Company</span></a>';
footer_menu01+='<ul>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/BUSINESS/"><span>Business Overview</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/EXECUTIVE/"><span>Executive Bios</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/ESTABLISHMENT/"><span>Facilities in Japan</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/EN_ESTABLISHMENT/"><span>Facilities Overseas</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/SUBSIDIARY/"><span>Major Subsidiaries and Affiliates</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/HERITAGE/"><span>Company Development, Heritage</span></a></li>';
footer_menu01+='</ul></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/HERITAGE/"><span>Nissan Heritage</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/DIVERSITY/"><span>Diversity</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/PROFILE/ALLIANCE/"><span>Renault-Nissan Alliance</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/RECRUIT/"><span>Career</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/COMPANY/LIBRARY/"><span>Company Information Library</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/CONSULTING/"><span>Nissan Consulting</span></a></li>';
footer_menu01+='<li><a href="'+root_uri01+'/EN/LICENSE/"><span>Licensing Business</span></a></li>';
footer_menu01+='</ul>';
footer_menu01+='</div></div>';

footer_menu02+='<!--box02--><div id="box02"><div id="box022">';
footer_menu02+='<!--02--><h3><a href="'+root_uri01+'/EN/PRODUCTS/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu02.gif" alt="PRODUCTS" /></a></h3>';
footer_menu02+='<ul class="linkList01">';
footer_menu02+='<li><a href="'+root_uri01+'/EN/NISSAN/"><span>Nissan</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/INFINITI/"><span>Infiniti</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/DATSUN/"><span>Datsun</span></a></li>';

//footer_menu02+='<li><a href="http://www.nissanlcv.com/EN/" target="_blank"><span>LCV (Light Commercial Vehicle)</span></a></li>';
footer_menu02+='<li><a href="http://www.nissanmarine.com/" target="_blank"><span>Marine</span></a></li>';
//footer_menu02+='<li style="background:none;"><span>&nbsp;</span></li><!--<li style="background:none;"><span>&nbsp;</span></li>-->';
//footer_menu02+='<!--<li style="background:none;"><span>&nbsp;</span></li>--><li style="background:none;"><span>&nbsp;</span></li>';
footer_menu02+='<li style="background:none;"><span>&nbsp;</span></li>';
	
footer_menu02+='</ul>';
footer_menu02+='<!--03--><h3><a href="'+root_uri01+'/EN/NEWS/index2.html"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu03.gif" alt="NEWS & EVENTS" /></a></h3>';
footer_menu02+='<ul class="linkList01">';
footer_menu02+='<li><a href="'+root_uri01+'/EN/NEWS/"><span>News Releases</span></a></li>';
footer_menu02+='<li><a href="http://reports.nissan-global.com/EN/"><span>Reports</span></a></li>';
footer_menu02+='<li><a href="http://photos.nissan-global.com/EN/"><span>Nissan Photo Gallery</span></a></li>';
footer_menu02+='<li><a href="http://blog.nissan-global.com/EN/"><span>Nissan Channel 23 Blog</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/NISSANCHANNEL/"><span>Nissan Channel 23 TV</span></a></li>';
footer_menu02+='<li><a href="http://www.nissan-motorsports.com/ENN/" target="_blank"><span>Motorsports</span></a></li>';
footer_menu02+='<li><a href="'+root_uri01+'/EN/MOTORSHOW/"><span>Motor Show</span></a></li>';
footer_menu02+='</ul>';
footer_menu02+='</div></div>';

footer_menu03+='<!--box03--><div id="box03"><div id="box032">';
footer_menu03+='<!--05--><h3><a href="'+root_uri01+'/EN/SOCIALCONTRIBUTION/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu04.gif" alt="SUSTAINABILITY" /></a></h3>';
footer_menu03+='<ul class="linkList01">';
footer_menu03+='<li><a href="'+root_uri01+'/EN/CSR/"><span>CSR</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/ENVIRONMENT/"><span>Environment</span></a></li>';
footer_menu03+='<li><a href="http://www.nissan-zeroemission.com/EN/" target="_blank"><span>Zero Emission</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/SAFETY/"><span>Safety</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/CITIZENSHIP/"><span>Corporate Citizenship</span></a></li>';
//footer_menu03+='<li style="background:none;"><span>&nbsp;</span></li>';

footer_menu03+='<!--<li style="background:none;">&nbsp;</li>-->';
footer_menu03+='</ul>';
footer_menu03+='<!--06--><h3><a href="'+root_uri01+'/EN/NISSANCRAFTSMANSHIP/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu05.gif" alt="CRAFTSMANSHIP" /></a></h3>';
footer_menu03+='<ul class="linkList01">';
footer_menu03+='<li><a href="'+root_uri01+'/EN/TECHNOLOGY/"><span>Technology</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/DESIGN/"><span>Design</span></a></li>';
footer_menu03+='<li><a href="'+root_uri01+'/EN/QUALITY/"><span>Quality</span></a></li>';
footer_menu03+='</ul>';
footer_menu03+='</div></div>';

footer_menu04+='<!--box04--><div id="box04"><div id="box042">';
footer_menu04+='<!--04--><h3><a href="'+root_uri01+'/EN/IR/"><img src="'+root_uri01+'/EN/SHARED/IMAGES/FOOTER-MENU/footer_menu06.gif" alt="FOR INVESTORS" /></a></h3>';
footer_menu04+='<ul class="linkList01">';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/MESSAGE/"><span>Message from CEO</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/NEWS/NEWSRELEASE/"><span>News</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/INDIVIDUAL/"><span>For Individual Investors</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/MIDTERMPLAN/"><span>Mid-term Plan</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FINANCIAL/"><span>Financial Announcements</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/LIBRARY/"><span>IR Library</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/EVENT/"><span>IR Events</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/INSIDE/"><span>Inside NISSAN</span></a></li>';
footer_menu04+='<li><a href="http://www.bloomberg.com/quote/7201:JP" onClick="s.pageName=\'CL:EN:IR:StockQuote\'; s.prop10=\'CL:EN:IR:StockQuote\'; s.prop11=\'For Investors\'; s.prop12=\'EN\'; s.t();" target="_blank"><span>Stock Quote</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/STOCK/"><span>Stock Information</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/SHAREHOLDER/"><span>Shareholders Meeting</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/CALENDAR/"><span>IR Calendar</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/RANK/"><span>Ratings Information</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/CORPORATEBOND/"><span>Bond Information</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/FAQ/"><span>Frequently Asked Questions (FAQ)</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/INQUIRY/"><span>Inquiry / Link</span></a></li>';
footer_menu04+='<li><a href="'+root_uri01+'/EN/IR/DISCLAIMER/"><span>Disclaimer</span></a></li>';

footer_menu04+='</ul>';
footer_menu04+='</div></div>';
footer_menu04+='</div><!--/footer-menu-->';
}
footer_menu00=footer_menu01+footer_menu02+footer_menu03+footer_menu04;


/*ready*/
//$(function(){
jQuery(document).ready(function($){
	if(disableDynamicHeaderFlag=='off'){
		var backupData01=$('h1#microSiteTitle').clone();
		var backupData02=$('ul#utilityNav').clone();
		$('div#header').empty().append(writeDynamicHeader00);
		$('div#header').append(backupData01);
		$('div#header').append(backupData02);
	}
	if(typeof(commonFooterMenuFlag)=="undefined"){
		$("div#footer").before(footer_menu00);
	}
	//
	$('img').set_rollovers();
	$('ul#globalNav > li').hover(
		function(){ $(this).addClass('hover'); },
		function(){ $(this).removeClass('hover'); }
	);
	$('ul#globalNav > li > ul').hover(
		function(){ $(this).parents('li').addClass('hover'); },
		function(){ $(this).parents('li').removeClass('hover'); }
	);
	//121003 charset_check
	var meta_charset01=$("meta[http-equiv=content-type]").attr("content");
	if(typeof meta_charset01=="undefined"){
		meta_charset01=$("meta[http-equiv=Content-Type]").attr("content");
	}
	if(typeof meta_charset01=="undefined"){
		meta_charset01=$("meta[http-equiv=CONTENT-TYPE]").attr("content");
	}
	if(typeof meta_charset01!="undefined"){
		var meta_charset02=meta_charset01.toLowerCase();
		var meta_charset03=meta_charset02.indexOf("utf-8");
		if(meta_charset03!=-1){
			$("input[name=ie]").attr("value","UTF8");
		}
	}
	//YEARS80
	if(YEARS80Flag=='off'){
		setTimeout(function(){
			$('div#header').css('cssText','height:74px!important;');
			$('p#ci-nissan').css('cssText','top:12px!important;');
			$('p#years80').remove();
		},0);
	}
});
//search
document.write('<script src="http://search2.nissan-global.com/site/js/suggest_ext.js#unitid=en_global" type="text/javascript" charset="UTF-8"></sc'+'ript>');

// error
window.onerror=function(){
	return true;
}