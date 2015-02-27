$(document).ready(function() {

	

$("a[data-toggle=popover]").popover({ 
	html: true 
}).click(function(e){
	e.preventDefault();
});

// show hide notes
$("#note-handle").click(function(){
	$('#page-notes').toggleClass('show');
});


	// groups start and end date
	$("#group_start_date" ).datepicker();
	$("#group_end_date" ).datepicker();

	$( ".tabs, #featured-image #tabs" ).tabs();
	$( ".accordion" ).accordion({
		heightStyle: "content"
	});

	$( ".header-text, .slider-content, .link-one, .link-two, .slide-settings" ).draggable({
		stop: function(event, ui) {
	        // Show dropped position.
	        var Stoppos = $(this).position();
	        //console.log(Stoppos.left + " " + Stoppos.top);
	        var id = $(this).find('p').attr('id');

	        if(id == undefined) {
	        	id = $(this).find('a').attr('id');
	        }

	        var top = id + "_top";
	        var left = id + "_left";
	        $("#" + top).val(Stoppos.top);
	        $("#" + left).val(Stoppos.left);

	        // console.log(top + " " + Stoppos.top);
	        // console.log($("#" + top));
    	}
	});

	$( ".slider-header-slider" ).slider({
		min: 0,
		max: 1000,
		slide: function( event, ui ) {
			id = $(this).attr('id');
			$(this).closest('.slide-settings').siblings('.slider-image').find('.header-text').css('width', ui.value +"px");
			$("." + id).val(ui.value);
			// console.log(ui.value);
		}
	});
	$( ".slider-content-slider" ).slider({
		min: 0,
		max: 1000,
		slide: function( event, ui ) {
			id = $(this).attr('id');
			$(this).closest('.slide-settings').siblings('.slider-image').find('.slider-content').css('width',  ui.value +"px");
			$(this).next('.content_width').val(ui.value);
			$("." + id).val(ui.value);
			// console.log($(this).closest('.content_width'))
		}
	});
	$('.cp-basic').colorpicker({
		select: function(event, color) {
						var elementId = $(this).attr("id");
						elementId = elementId.replace('color_','');
						$("#" + elementId).css("color", "#" + color.formatted)
						console.log(elementId);
						}
	});






// set active for link on side nav
var url = window.location;
$('ul.nav-side a').filter(function () {
    return this.href == url;
}).parent('li').addClass('active').parents('ul').addClass('current').closest('ul').slideDown().siblings('span').addClass('current');



// data tables
$('#sortable-table').dataTable({
    iDisplayLength: 25,
    "aLengthMenu": [25, 50, 100, 150, 200, "All"],
    sDom: "<'row-fluid' <'span4'l> <'span8'pf> > rt <'row-fluid' <'span12'i> >"
});

// data tables
$('#versions-table').dataTable({
	"aaSorting": [[ 1, "desc" ]],
    iDisplayLength: 25,
    "aLengthMenu": [25, 50, 100, 150, 200, "All"],
    sDom: "<'row-fluid' <'span4'l> <'span8'pf> > rt <'row-fluid' <'span12'i> >"
});

// data tables
$('#rewrites-table').dataTable({
	"aaSorting": [[ 0, "desc" ]],
    iDisplayLength: 25,
    "aLengthMenu": [25, 50, 100, 150, 200, "All"],
    sDom: "<'row-fluid' <'span4'l> <'span8'pf> > rt <'row-fluid' <'span12'i> >"
});
// data tables
$('#page-content-table').dataTable({
	"bSort": false,
    iDisplayLength: 50,
    "aLengthMenu": [50, 100, 150, 200, "All"],
    sDom: "<'row-fluid' <'span4'l> <'span8'pf> > rt <'row-fluid' <'span12'i> >"
});


$('#admin-sidebar ul li span').click(function(){
			$(this).closest('li').siblings().removeClass('current').find('span').removeClass('current').siblings('ul').slideUp();
			$(this).siblings('ul').slideToggle();
			$(this).toggleClass('current');
	});
	
// hide flash messages	
$('.success').delay(6000).slideUp('slow');
$('.notice').delay(6000).slideUp('slow');
$('.alert').delay(6000).slideUp('slow');


// section forms	
$('.section-tabs a').click(function(e){
	e.preventDefault();
	$(this).closest('li').siblings().find('a').removeClass('current');
	$(this).addClass('current');
	$(this).closest('li').siblings().find('.section-form').hide();
	$(this).siblings('.section-form').fadeIn();
	});	

//fly out
$('.section-toolbar > ul > li a').click(function(e){
	var sectionLinks = $(this).next('.section-links');
	e.preventDefault();
	$(this).addClass('current');
	$(this).closest('li').siblings().find('a').removeClass('current');
	$(this).closest('li').siblings('li').find('.section-links').hide();
	$(this).closest('section').siblings('.section-toolbar').find('.section-links').hide();
	$(this).closest('.section-toolbar').siblings('section').find('.section-links').hide();
	$(this).closest('li').siblings('li').find('.section-form').hide();

	sectionLinks.slideToggle();
	sectionLinks.mouseleave(function(){
		// console.log('worked');
		$(this).slideUp();
	});
});
	

// footer show form
$('.footer-tab-links a').click(function(){
	link = $(this).attr('href');
	console.log(link);
	$(this).closest('.data-container').siblings().find('.footer-tabbed-content').slideUp();
	$(link).slideToggle();
	})

$(".col-div").first().show();
$('.section_cols').change(function(){
		// hide divs if any are showing
		$(".col-div").hide();
		
		divId = $(this).val();
		//console.log(divId);
		//console.log(".col-" + divId)
		$(this).closest('.content-input').find(".col-" + divId).show();	
		
		});


	// page sorting 
	$('ol.sortable').nestedSortable({
		handle: 'div',
		cursor: 'crosshair',
		placeholder: 'ui-state-highlight',
		items: 'li',
		opacity: 0.4,
		revert: 250,
		tabSize: 25,
		tolerance: 'pointer',
		toleranceElement: '> div',
		update: function(event, ui){
			
			//parent group
			parentGroup = $(ui.item).prev('li').attr('data-parent_id');
			if(typeof(parentGroup) == 'undefined'){
				parentGroup = $(ui.item).next('li').attr('data-parent_id');
				} 
			
			//current = $(this).find('li').attr('data-parent_id');
			navigation = $(this).find('li').attr('data-navigation');
			
			// current id
			currentID = $(ui.item).attr('id');



			// previous id
			prevID = $(ui.item).prev('li').attr('id');
			if(typeof(prevID) == 'undefined'){
				// find the list item
				prevID = $(ui.item).closest('ol').parent('li').attr('id');
				}
			if(typeof(prevID) == 'undefined'){
				// if no list item...fine ol  id
				prevID = $(ui.item).closest('ol').attr('id');
				}
			
			var childOf = $(ui.item).closest('ol').parent('li').attr('id');
			if(typeof(childOf) == 'undefined'){
				childOf = 0;
				} else {
					childOf = childOf.replace('page_','');
				}
			
			// previous position
			prevousPosition = $(ui.item).prev('li').attr('data-position');
			if(typeof(prevousPosition) == 'undefined'){
				 prevousPosition = 0
				}
			// next position
			nextPosition = $(ui.item).next('li').attr('data-position');
			if(typeof(nextPosition) == 'undefined'){
				 nextPosition = $(ui.item).closest('ol').parent('li').next('li').attr('data-position');
				}
			
			// get what we want
			currentID 	=  currentID.replace('page_','');
			prevID 		=  prevID.replace('page_','');
			
			if(currentID == 1){
				alert("You are trying to move the home page. This will not take effect.");
				location.reload();
				return;
			}

			if (prevID == "admin_nav_1") {
				alert("You cannot move a page into the home position. Just stop it!");
				location.reload();
				return;
			}

			// read out 
			//console.log('current id: ' + currentID + "\n previous id: " + prevID + "\n previous position: " + prevousPosition + "\n next position: " + nextPosition + "\n child of :" + childOf + "\n navigation group: " + navigation + "\n parent group: " + parentGroup);


		$.ajax({
			type: 'post',
			data: {page_id: currentID, parent_id: prevID, previous_position: prevousPosition, next_position: nextPosition, child_of: childOf, navigation_group: navigation, parent_group: parentGroup},
			dataType: 'script',
			complete: function(request){
			$(this).closest(".admin-nav").effect('highlight');
			},
			url: '/admin/pages/sort'
			})
			}
		});	

//category update for 
//hide all submit buttons

$('.submittable').live('change', function() {
  $(this).parents('form:first').submit();
	$(this).parents('td').effect('highlight');
	$(this).parents('.tab-pane').effect('highlight');
	return false;
});



//fancy box

$(".fbox").fancybox({
	topRatio    : .20,
	fitToView	: true,
	closeBtn    : false,
	maxHeight   : 800,
	beforeShow: function () { 
		tinyMCE.init({
			width : '500',
			height : '320',
			mode : "specific_textareas",
			editor_selector : "mceEditor",
			theme: 'modern',
		    plugins: [
		        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
		        "searchreplace wordcount visualblocks visualchars code fullscreen",
		        "insertdatetime media nonbreaking save table contextmenu directionality",
		        "emoticons template paste textcolor"
		    ],
			relative_urls : false,
			remove_script_host : false
		}); 
	},
	beforeClose: function () { 
		tinymce.EditorManager.execCommand('mceRemoveControl',true, 'textareaTinyMce');
	}
	
});

// used for articles/posts adding assets
$(".fbox2").fancybox({		
	minWidth	: 800,
	minHeight	: 400
});


$(".fboxForm").fancybox({
	closeBtn    : false,
	minWidth	: 600,
	topRatio   : .25
});

$(".fboxPages").fancybox({
	closeBtn   : false,
	topRatio   : .25	
});
$(".fboxTop").fancybox({
	closeBtn   : false,
	topRatio   : .125	
});

$(".fboxSmall").fancybox({
	closeBtn    : false,		
	maxWidth	: 800,
	maxHeight 	: 600
});

$(".flashBox").fancybox({		

});

$(".fbox-asset").fancybox();

	
$(".pageForm").fancybox({
	closeBtn    : false,		
	maxHeight 	: 800,
	maxWidth	: 800,
});
	
// hide move-content-toolbar and show toolbar

$('.hide-move-content-toolbar, .cancel-move-content').click(function(){
	$('.move-content-toolbar').hide();
	$('.section-toolbar').fadeIn();
	$('.cancel-move-content').hide();
})



// Moving sections
$('.move-content-toolbar').hide();
	
$(".move-section").click(function(){
	$('.section-toolbar').hide();
	$('.move-content-toolbar').show();
	$(this).parent('li').siblings('.cancel-move-content').show();

	
	var currentId = '';
	currentId = $(this).attr("data-current");
	
	$('.sec-'+ currentId).find('.move-content-toolbar').hide();
	$(this).closest('.section-toolbar').show();
	$(this).closest('.section-toolbar').next('.move-content-toolbar').hide();

			
$('.move-data').click(function(){
	stat = $(this).attr("data-stat");
	subString = stat.split('-')
	targetId = 	subString[0];
	positionId = subString[1];
	parentId = subString[2];
	pageId = subString[3];
	locId = subString[4];
	pubId = subString[5];

	if(!pageId) { pageId = null;}
	if(!pubId) { pubId = null};

	// console.log("target id: " + targetId + ' Position: ' + positionId + " parent id: " + parentId + ', ' + ' location: ' + locId + ' Publication: ' + pubId)
	
	$.ajax({
		type: 'post',
					data: {target_id: targetId,position_id: positionId, 
									parent_id: parentId, current_id:currentId, page_id: pageId,loc_id:locId,pub_id:pubId },
		dataType: 'script',
		complete: function(request){
		window.location.reload();
		},
		 url: "/admin/pages/"+ pageId +"/sections/sort"
		})
	});
});

$("#show-hide-toolbar").click(function(){
	var text = $(this).text();
	if (text == 'Hide Toolbars') {
		$(this).text("Show Toolbars");
		$(".section-toolbar").hide();
	}else {
		$(this).text("Hide Toolbars");
		$(".section-toolbar").show();
	}
})	
	
$(".custom-html-link").click(function(){
	// var imageContainer = $(this).closest('.slider-image');
	// imageContainer.find('.slide-settings').fadeToggle();

	var container = $(this).closest('.widget-header').siblings('.widget-content');
	container.find('.slide-settings').fadeToggle();
	return false;
});


//$('form.edit_slide input,form.edit_slide textarea').keyup(function() {
$('form.edit_slide input,form.edit_slide textarea,form.new_slide input,form.new_slide textarea').keyup(function() {
  var value = $(this).val();
  var inputId = $(this).attr('data-input');
  $("#" + inputId).text(value);
  console.log(inputId);
});

$(".control").click(function(){
	$(this).parent().siblings().find('.html-content').slideUp();
	$(this).siblings('.html-content').slideToggle();
})
$(".closer").click(function(){
	$(this).closest('.slide-settings').hide();
});

//slide update
$('.slideshow-featured-image-controls').live('click',function(){
	var src = $(this).attr('data-image');
	var imageId = $(this).attr('data-id');
	
	var image = "<img src='" + src + "'>";
	console.log(image);
	$('#image-placeholder').empty();
	$('#image-placeholder').append(image);
	//slide_image_id
	$("#slide_image_id").val(imageId);

});

$('.show-link').click(function(e){
	e.preventDefault();
	$(this).next('.element-shown').slideToggle();
});

$('#image-assets ul li').live('mouseenter',function(){
		$(this).find('.featured-image-controls').stop().fadeToggle();
	}).live('mouseleave',function(){
		$(this).find('.featured-image-controls').stop().fadeToggle();
	});

// header click items
$(".data-container-header").click(function(){
	$(this).toggleClass('hiddenContent');
	$(this).next(".data-container-content").slideToggle();
	
});

// remote forms
$('.btn.remote-form').live('click',function() {
	tinyMCE.triggerSave(true,true);
	$(this).closest('form').submit();
	window.location.reload();
	});

// galleries and play lists
$('#gallery-playlist .nailthumb-container.show-loading, #gallery-content .nailthumb-container.show-loading').nailthumb({
        titleAttr: '',
        imageFromWrappingLink: true,

});


// Gallery Assets list (far right)
//jpages
$("ul.holder").jPages({
        containerID: "gallery-playlist",
        perPage: 12,
        midRange: 3,
        previous: "previous",
        next: "next",
        callback: function (pages, items) {
                $("#legend").html(items.range.start + " - " + items.range.end + " of " + items.count);
                $("#gallery-content").find('.thumbnail').removeClass('jp-hidden');
        }
});


$("#showItem ul li a").click(function () {
        var newPerPage = parseInt($(this).attr('data-page'));
        $("ul.holder").jPages("destroy").jPages({
                containerID: "gallery-playlist",
                perPage: newPerPage
        });
        $("#drop-down-label").html(newPerPage + ' ');

});



$('#gallery-content a.asset-transfer-link').each(function(index){
		$(this).html("<i class='fontello-icon-exchange'></i> Remove From Gallery");
});

// show hide category inputs based on 'use categories'
$('#category-filter').hide();
if($('#collection_settings_categories').is(':checked')){
	$('#category-filter').show();
}


// Moving gallery assets
// Capture filter click events.
// $('.gall-filters li').click(onClickFilter);
$('#category-filter input').click(onClickFilter);

// transfer assets back and fourth
$("#gallery-playlist a.asset-transfer-link").live('click',function(e){
	e.preventDefault();
	$(this).html("<i class='fontello-icon-exchange'></i> Remove From Gallery");
	var imgVal = $(this).closest('div.thumbnail');
	imgVal.appendTo("#gallery-content");
	galleryAssets();
});

$("#gallery-content a.asset-transfer-link").live('click',function(e){
	e.preventDefault();
	$(this).html("<i class='fontello-icon-exchange'></i> Add To Gallery");
	var imgVal = $(this).closest('div.thumbnail');
	imgVal.appendTo("#gallery-playlist");
	galleryAssets();
});

// galleries sorting
$('#gallery-content').sortable({
      placeholder: "ui-state-highlight",
      stop: function( event, ui ) {
      	galleryAssets();
      }
    });

if($('#collection_settings_categories').is(':checked')) {
		$('.asset-transfer-link').hide();
		
	} else {
		$('.asset-transfer-link').show();
		
	} 

$('#collection_settings_categories').mouseup(function() {
    if (!$(this).is(':checked')) {
        $('.asset-transfer-link').hide();
        $('#category-filter').show();
    } else {
    	$('.asset-transfer-link').show();
    	$('#category-filter').hide();
    }
});



// internal links ofn slide page creation and add

$('#internal-links-list li ol').hide();
$("#internal-links-list li").mouseenter(function(){
  $(this).find('> ol').stop(true,true).slideDown(100);
  changeClass($(this), 'fontello-icon-right-open-1', 'fontello-icon-down-open-1');

}).mouseleave(function(){
  $(this).find('ol').stop(true,true).slideUp(100);
  changeClass($(this), 'fontello-icon-down-open-1', 'fontello-icon-right-open-1');
});

$('#internal-links-list a').click(function(){
  var link = $(this).data('page');
  var slide = $(this).data('slide');
  $('#' + slide).val("/" + link);
});

  // add classes on slider choose internal links popup
$('.sub-nav').prev('a').addClass('fontello-icon-right-open-1');

var changeClass = function(obj, originalClass, newClass) {
    var  link = obj.find('a').first();
    if(link.hasClass(originalClass)) {
      link.removeClass(originalClass);
      link.addClass(newClass);
    }
}

// engage list filter 
listFilter($('#users-list'),$('#users-list'));

});
// end of doc ready



var onClickFilter = function (event) {
        var item = $(event.currentTarget);

        var category = item.attr('data-filter');
        var categoryId = item.attr('data-categoryId');
        
        if(item.hasClass('active')) {
        	moveThumbNail("#gallery-playlist", "#gallery-content", category);
        	item.removeClass('active');
        } else {
        	item.toggleClass('active');
        	moveToGallery(category);
        }   

        var categoryFilter = [];

        $('#category-filter input').each(function( i, ele){
        	var catId = $(ele).attr('data-categoryId');
			if($(ele).hasClass('active')) {
            	categoryFilter.push(catId);
             }
        });

        $("#collection_settings_category_ids").val(categoryFilter.join(','));
        // update assets
    	galleryAssets();

}

// button filter 
var moveToGallery = function (category) {
	moveThumbNail("#gallery-content" , "#gallery-playlist", category)
}


var moveThumbNail = function(to, from, category) {
	// console.log( to + ' ' + from)
	$(from + " div.thumbnail").each(function(i, ele){
		if($(ele).hasClass(category)) {
			$(ele).removeClass('jp-hidden');
			$(ele).appendTo(to);
		}
	});

	//rebuild pagination jpages
	$("ul.holder").jPages("destroy").jPages({
            containerID: "gallery-playlist"
    });
}

// update assets for galleries. fills out hidden field
var galleryAssets = function(){
	var galleryAssets = [];
    $('#gallery-content .thumbnail').each(function( i, ele){
    	var catId = $(ele).attr('data-asset');
        galleryAssets.push(catId);
    });
    console.log(galleryAssets.join(','));
    $("#collection_settings_asset_ids").val(galleryAssets.join(','));
}

// list filter for side nav

	 jQuery.expr[':'].Contains = function(a,i,m) {
      return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
  	};


	function listFilter(theId, list) {
		var li = $("<li>"), form = $("<form>").attr({'class':'filter-form'},{'action':"#"}), input = $("<input>").attr({'class':'filter-input', 'type':'text'});
		$(form).append(input).prependTo(theId);

		$(input).change(function(){
			var filter = $(this).val();
			console.log(filter);
			if (filter) {
				$(list).find("a:not(:Contains(" + filter + "))").parent().slideUp(); 
				$(list).find("a:Contains(" + filter + ")").parent().slideDown(); 
			} else {
				$(list).find("li").slideDown();
			};
			
		}).keyup(function(){
			$(this).change();
		});
	}

