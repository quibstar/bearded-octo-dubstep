$(document).ready(function (){
	$('#new_publication').validate({
			rules: {
					'publication[title]': {
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

	$('#edit_publication').validate({
			rules: {
					'publication[title]': {
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