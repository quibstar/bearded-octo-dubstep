$(document).ready(function (){
	$('#new_help').validate({
			rules: {
					'help[help_category]': {
							required: true
					},
					'help[title]': {
						required: true
					},
					'help[content]': {
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

	$('#edit_help').validate({
			rules: {
					'help[help_category]': {
							required: true
					},
					'help[title]': {
						required: true
					},
					'help[content]': {
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