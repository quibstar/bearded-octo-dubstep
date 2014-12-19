$(document).ready(function (){
	$('#new_form').validate({
			rules: {
					'form[title]': {
							required: true
					},
					'form[recipient]': {
						required: true
					},
					'form[description]': {
						required: true
					},
					'form[confirmation]': {
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

	$('#edit_form').validate({
			rules: {
					'form[title]': {
							required: true
					},
					'form[recipient]': {
						required: true
					},
					'form[description]': {
						required: true
					},
					'form[confirmation]': {
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