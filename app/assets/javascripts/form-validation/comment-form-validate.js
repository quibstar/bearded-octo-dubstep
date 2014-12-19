$(document).ready(function (){
	$('#new_comment').validate({
			rules: {
					'comment[name]': {
							required: true
					},
					'comment[email]': {
							required: true
					},
					'comment[comment]': {
							required: true
					},
			},
			
			highlight: function (label) {
					$(label).closest('.control-group').addClass('error');
			},
			errorPlacement: function (error, label) {
					$(label).closest('.controls').append(error);
			}
	});	
	$('#new_reply_comment').validate({
		rules: {
				'comment[name]': {
						required: true
				},
				'comment[email]': {
						required: true
				},
				'comment[comment]': {
						required: true
				},
		},
		
		highlight: function (label) {
				$(label).closest('.control-group').addClass('error');
		},
		errorPlacement: function (error, label) {
				$(label).closest('.controls').append(error);
		}
	});		
});