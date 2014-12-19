$(document).ready(function() {
$('.section_cols').change(function(){

		// hide divs if any are showing
		$(".col-div").hide();
		
		divId = $(this).val();
		console.log(divId);
		console.log(".col-" + divId);
		$(this).closest('.content-input').find(".col-" + divId).show();	
		// update content height
		$.fancybox.update();
		});
	
});