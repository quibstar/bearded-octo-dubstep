$(document).ready(function (){
	$('#new_audio').validate({
			rules: {
					'audio[artist]': {
							required: true
					},
					'audio[title]': {
							required: true
					},
					'audio[audio]': {
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
// audio[audio]
	$('#edit_audio').validate({
			rules: {
					'audio[artist]': {
							required: true
					},
					'audio[title]': {
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