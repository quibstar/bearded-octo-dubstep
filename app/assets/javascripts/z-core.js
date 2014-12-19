$(document).ready(function() {	

	$('#menu-btn').mobileNav();

	// navigation drop down 
	$('#primary li, #constant li, .navigation-group li').mouseenter(function(){
		$(this).find('> ol').show();
		$(this).find('.multi-nav').show();
	}).mouseleave(function(){
		$(this).find('ol').hide();
		$(this).find('.multi-nav').hide();
	});


	$('#left-side-nav ol li').mouseenter(function(){
		$(this).find('> ol').stop().fadeIn();
	}).mouseleave(function(){
		$(this).find('ol').stop().fadeOut();
	});

	$( ".tabs" ).tabs();
	$( ".accordion" ).accordion({
			// autoHeight: false,
			heightStyle: "content"
		});

		
	$(".fbox-asset").fancybox({});
	$(".fbox").fancybox({});
	$(".fbox-copy").fancybox({
		closeBtn    : false
	});
	
	$(".show-sub").click(function(){
		$(this).toggleClass('down');
		$(this).next('.first-list').slideToggle();
		$(this).closest('li').siblings().find('ol').slideUp();
		$(this).closest('li').siblings().find('span').removeClass('down');
	});

	$('.custom-form').tooltip({
	  selector: "a[data-toggle=tooltip]"
	})

	$("a[data-toggle=popover]")
	      .popover({ trigger: "hover" });


	$('.search').click(function () {
	    if(jQuery('.search-btn').hasClass('icon-search')){
	        jQuery('.search-open').fadeIn(500);
	        jQuery('.search-btn').removeClass('icon-search');
	        jQuery('.search-btn').addClass('icon-remove');
	    } else {
	        jQuery('.search-open').fadeOut(500);
	        jQuery('.search-btn').addClass('icon-search');
	        jQuery('.search-btn').removeClass('icon-remove');
	    }   
	}); 

});

(function($){
	$.fn.mobileNav = function(options){	
		var settings = $.extend({
			action : 'show-nav',
			target : '.m-nav'
		}, options);

	this.click(function(e){
		e.preventDefault();
			$(settings.target).toggleClass(settings.action);
		});
	};
})(jQuery);