$(document).ready(function (){
	$('#new_user').validate({
			rules: {
					'user[email]': {
							required: true
					},
					'user[password]': {
							required: true
					},
					'user[first_name]': {
							required: true
					},
					'user[last_name]': {
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

	$('#edit_user').validate({
			rules: {
					'user[email]': {
							required: true
					},
					'user[password]': {
							required: true
					},
					'user[first_name]': {
							required: true
					},
					'user[last_name]': {
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