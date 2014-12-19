$(document).ready(function (){
	$('#new_multi_navigation').validate({
			rules: {
					'multi_navigation[title]': {
							required: true
					},
					'multi_navigation[dynamic_content_width]': {
							required: true
					}
			},
			
			highlight: function (label) {
					$(label).closest('.control-group').addClass('error');
			},
			success: function (label) {
					$(label).text('OK!').addClass('valid')
							.closest('.control-group').addClass('success');
			},
			errorPlacement: function (error, label) {
					$(label).closest('.controls').append(error);
			}
	});

	$('#edit_multi_navigation').validate({
			rules: {
					'multi_navigation[title]': {
							required: true
					},
					'multi_navigation[dynamic_content_width]': {
							required: true
					}
			},
			
			highlight: function (label) {
					$(label).closest('.control-group').addClass('error');
			},
			success: function (label) {
					$(label).text('OK!').addClass('valid')
							.closest('.control-group').addClass('success');
			},
			errorPlacement: function (error, label) {
					$(label).closest('.controls').append(error);
			}
	});			
});