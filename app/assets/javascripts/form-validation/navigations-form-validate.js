$(document).ready(function (){
	$('#new_navigation').validate({
			rules: {
					'navigation[nav_group]': {
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

	$('#edit_navigation').validate({
			rules: {
					'navigation[nav_group]': {
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