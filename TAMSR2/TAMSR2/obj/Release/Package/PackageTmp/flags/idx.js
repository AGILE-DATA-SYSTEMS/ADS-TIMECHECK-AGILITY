
function pageScrl(_hash) {	
	$('html,body').stop(true, true);
	
	var target = $(_hash);
	if (target.length) {
		var sclpos = 30;
		var scldurat = 600;
		var targetOffset = target.offset().top - sclpos;
		$('html,body').animate({scrollTop: targetOffset}, {duration: scldurat, easing: "easeOutExpo"});
	}
}

/*-------------------------------------------------------------------
   Social Page List Data
-------------------------------------------------------------------*/

function parseSocialHTML(social_html) {
	
	var obj_table = $(social_html).find('#social-table');
	
	$('.tipArea').each(function(){
		
		var nam = $(this).prev('h4').find('.country').text();
		var node_ary = new Array();
		
		if(nam != 'Europe') {
			$(obj_table).find('.col_country').each(function(){
				if($(this).text() == nam) {
					node_ary.push($(this).parent('tr'));
					return false;
				}
			});
			var n = Number($(node_ary[0]).find('.col_country').attr('rowspan'));
			if(!isNaN(n)) {
				for(var i=0; i<n-1; i++){
					node_ary.push($(node_ary[node_ary.length-1].next('tr')));
				}
			}
		} else {
			$(obj_table).find('.col_region').each(function(){
				if($(this).text() == nam) {
					node_ary.push($(this).parent('tr'));
				}
			});
			var n = Number($(node_ary[0]).find('th:eq(1)').attr('rowspan'));
			if(!isNaN(n)) {
				for(var i=0; i<n-1; i++){
					node_ary.push($(node_ary[node_ary.length-1].next('tr')));
				}
			}
		}
		
		if(node_ary.length > 0) {
			
			var code_ary = new Array();
			
			for(var i=0; i<node_ary.length; i++) {
				
				var str0 = $(node_ary[i]).find('td:first').text();
				
				$(node_ary[i]).find('td a').each(function(){
					var str1 = '';
					var str2 = '<a href="'+$(this).attr('href')+'" target="_blank">'+str0+'</a>';
					
					if($(this).parent().hasClass('col_facebook')) {
						str1 = '<li class="facebook">';
					} else if($(this).parent().hasClass('col_twitter')) {
						str1 = '<li class="twitter">';
					} else if($(this).parent().hasClass('col_youtube')) {
						str1 = '<li class="youtube">';
					} else if($(this).parent().hasClass('col_ustream')) {
						str1 = '<li class="ustream">';
					} else if($(this).parent().hasClass('col_other')) {
						str1 = '<li class="other">';
					} else if($(this).parent().hasClass('col_other_googleplus')) {
						str1 = '<li class="googleplus">';
					} else if($(this).parent().hasClass('col_other_flickr')) {
						str1 = '<li class="flickr">';
					}
					
					code_ary.push(str1 + str2 + '</li>');
				});
			}
			
			for(var i=0; i<code_ary.length; i++){
				$(this).append(code_ary[i]);
			}
		}
	});
	
	setTipBtn();
}

/*-------------------------------------------------------------------
    List Tip
-------------------------------------------------------------------*/

function setTipBtn() {
	
	$('.tipArea').prepend('<li class="closeBt"><a href="#"></a></li>')
	
	$('.tipArea').prev('h4').find('.country').wrapInner('<a href="#"></a>');
	
	var obj = $('.tipArea').prev('h4').find('.country a');
	
	
	$(obj).css({ 'cursor': 'pointer' }).mouseenter(function(){
		$(this).css({
			'color' : '#003f65',
			'text-decoration' : 'underline'
		});
		setTip($(this).parent().parent().parent());
	}).click(function(){
		return false;
	});
	
}


function setTip(_obj){
	$('#tipWrapper .tipArea').remove();
	
	var node = $(_obj).find('.tipArea');
	$(node).clone().appendTo('#tipWrapper');
	
	$('#tipWrapper .tipArea').show();
	var h = $(node).outerHeight();
	
	$('#tipBg').css({
		'height' :	h
	});
	
	$('#tipWrapper').css({
		'height' :	h
	});
	
	var posX = $(_obj).offset().left - 11;
	var posY = $(_obj).offset().top - 4;
	
	$('#tipBlock').mouseleave(function(){
		$(_obj).find('.country a').css({
			'color' : '#666',
			'text-decoration' : 'none'
		});
		hideTip();
	});
	
	$('#tipWrapper .closeBt').click(function(){
		$(_obj).find('.country a').css({
			'color' : '#666',
			'text-decoration' : 'none'
		});
		
		hideTip();
		return false;
		
	});
	
	$('#tipBlock').css({ 'top': posY, 'left':posX }).fadeIn(180);

}

function hideTip(){
	$('#tipBlock').stop(true, true);
	$('#tipWrapper .tipArea').remove();
	$('#tipBlock').hide();
}

/*-------------------------------------------------------------------
    Regional List Open / Close
-------------------------------------------------------------------*/
function get_E_C_key(_obj) {
	if ($(_obj).hasClass('Americas')) {
		return 'Americas';
	} else if ($(_obj).hasClass('Europe')) {
		return 'Europe';
	} else if ($(_obj).hasClass('Asia')) {
		return 'Asia';
	} else if ($(_obj).hasClass('Africa')) {
		return 'Africa';
	} else {
		return 'not Region';
	}
}

function showRegionItems(_key) {
	var obj = $('#listBlk_'+_key);
	
	$(obj).stop(true, true);
	
	
	var slct = $('.'+_key);
	var txt ="";
	
	if($(obj).hasClass('opened')) {
		$(obj).slideUp(300).removeClass('opened');
		
		if($(slct).hasClass('Collapse')) {
			$(slct).removeClass('Collapse');
		}
		if(!$(slct).hasClass('Expand')) {
			$(slct).addClass('Expand');
		}
	} else {
		$(obj).slideDown(300).addClass('opened');
		
		if(!$(slct).hasClass('Collapse')) {
			$(slct).addClass('Collapse');
		}
		if($(slct).hasClass('Expand')) {
			$(slct).removeClass('Expand');
		}
	}
}

/*-------------------------------------------------------------------
    jQuery Document Ready
-------------------------------------------------------------------*/

var region_ary = new Array();

$(function(){
	
	/*  first View List Area  */
	
	$('.tipArea').hide();

	region_ary[0] = $('#listBlk_Americas');
	region_ary[1] = $('#listBlk_Europe'); 
	region_ary[2] = $('#listBlk_Asia');
	region_ary[3] = $('#listBlk_Africa');

	
	$('.regional_map_btn').css({'display': 'block'});
	
	for(var i=0; i<region_ary.length; i++) {
		region_ary[i].addClass('opened').show();
	}
	
	/*  Button Setting  */
	
	$('.regional_map_btn').hover(function(){
		if ($(this).hasClass('Collapse')) {
			$(this).css({'background-position' : '-71px -16px'});	
		} else {
			$(this).css({'background-position' : '0 -16px'});	
		}
	}, function(){
		if ($(this).hasClass('Collapse')) {
			$(this).css({'background-position' : '-71px 0'});	
		} else {
			$(this).css({'background-position' : '0 0'});	
		}
	}).click(function(){
		/*
		if($(this).hasClass('Expand')){
			pageScrl($(this).attr('href'));
		}
		*/
		var str = get_E_C_key($(this));
		showRegionItems(str);
		return false;

	});

	/*  Clickable Map Area */
	
	$('#NI-main-visual_map area').click(function(){
		pageScrl($(this).attr('href'));
		return false;
	});
	
	$('.regonal_map_col dt a').click(function(){
		pageScrl($(this).attr('href'));
		return false;
	});
	
	/*============  Get Social Data  ============*/

	$.ajax({
		type     : "GET",
		url      : "/EN/SOCIAL/index.html",
		dataType : "html",
		cache    : false,
		success  : function(social_html) { parseSocialHTML(social_html); },
		error    : function () {  }
	});



});