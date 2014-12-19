$(document).ready(function() {
	
	//tabs for form builder page
	$('.form-tab-header a').first().addClass('current');
	$('.form-tabbed-content').first().show();
	
	$('.form-tab-header a').click(function(){
		$(this).closest('li').siblings().find('a').removeClass('current');
		$(this).addClass('current');
		link = $(this).attr('href');
		$('.form-tabbed-content').hide();
		console.log(link);
		$(link).show();
		})
	$(".form-closer").live('click',function(){
		$(this).closest(".fields-right").hide();
	});
	
	//form builder
	
	var formBuilder = 		$('#form-builder ul')
	var fieldsLeft = 		$('#form-builder ul li .fields-left');
	var fieldsRightLabel = 	$('#form-builder ul li .fields-right .label');
	var required = 			$('#form-builder ul li .fields-right .req');
	var multiInput = 		$('#form-builder ul li .fields-right.multi-origin input.keyup');
	var multiRadio = 		$('#form-builder ul li .fields-right.multi-origin input[type="radio"]');
	var multiCheck = 		$('#form-builder ul li .fields-right.multi-origin input[type="checkbox"]');
	var multiSelect = 		$('#form-builder ul li .fields-right.multi-origin.dropdown input[type="radio"]');
	var multiSelectText = 	$('#form-builder ul li .fields-right.multi-origin.dropdown input[type="text"]');
	var deleteField = 		$('#form-builder ul li .fields-left .del');
	var addOption = 		$('#form-builder ul li .fields-right .opt-add');
	var deleteOption = 		$('#form-builder ul li .fields-right .opt-del');
	
	$('.add-fields').click(function(e){
		e.preventDefault();
		
		});
	
	function serial(){
		
		// use date for serialization
		var now = new Date();
		var serial = now.getMilliseconds()
		num = serial * Math.floor(Math.random()*2000);
		return num;
		}

	
	$('.add-fields li a').click(function(){
		type = $(this).attr("data-type");
		
		// hide right side incase there is one open
		$('.fields-right').hide();
		//get type
		switch(type)
		{
		case 'name':
			textField(type, serial());
		  break;
		case 'address':
		  addressField(type, serial());
		  break;
		case 'email':
		  textField(type, serial());
		  break;
		case 'phone':
		  textField(type, serial());
		  break;
		case 'date':
		  dateField(type, serial());
		  break;
		case 'website':
		  textField(type, serial());
		  break;
		case 'text':
		  textField(type, serial());
		  break;
		case 'textarea':
		  textArea(type, serial());
		  break;
		case 'radio':
		  fieldWithOptions(type, serial());
		  break;
		case 'checkbox':
		  fieldWithOptions(type, serial());
		  break;
		case 'dropdown':
		  dropDown(type, serial());
		  break;
		case 'dividerline':
		  dividerLine(type, serial());
		  break;
		}
	});
	
	
	//custom 
	function addressField(type,serialize) {
		html = '<li><div class="fields-left"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div><label class="label" for="address">Address</label>\
					<input  size="30" type="text"readonly="readonly" disabled="disabled">\
					</div>';
		html += rightCol('address', serial());
		html += '</li><li>\
					<div class="fields-left"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div><label class="label" for="address">Address 2</label>\
					<input  size="30" type="text"readonly="readonly" disabled="disabled">\
					</div>';
		html += rightCol('address2', serial());
		html +=	'</li><li>\
					<div class="fields-left"><div class="edit  fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div><label class="label" for="city">City</label>\
					<input size="30" type="text"readonly="readonly" disabled="disabled">\
					</div>';
		html += rightCol('city', serial());
		html +=	'</li><li>\
					<div class="fields-left"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div><label class="label" for="state">State</label>\
					<select readonly="readonly" disabled="disabled">\
					  <option value="alabama">Alaska</option>\
					</select>\
					</div>';
		html += rightCol('state', serial());
		html +=	'</li><li>\
					<div class="fields-left"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div><label class="label" for="zip">Zip</label>\
					<input  size="30" type="text"readonly="readonly" disabled="disabled">\
					</div>';
		html += rightCol('zip', serial());
		html +=	'</li>';
				
		formBuilder.append(html);
		
		}
		
	function dateField(type,serialize) {
		html = '<li><div class="fields-left date"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div>\
                      <label class="label">'+ type +'</label>\
                      <span class="required">*</span>\
                      <input type="text" readonly="readonly" disabled="disabled"> - \
                      <input type="text" readonly="readonly" disabled="disabled"> - \
                      <input type="text" readonly="readonly" disabled="disabled"><br />\
                      <span class="month">MM</span><span class="day">DD</span><span class="year">YY</span>\
                    </div>\
        			<div class="fields-right">\
        			  <img alt="White-left-arrow" class="left-arrow" src="/assets/white-left-arrow.png">\
                      <label >Field Label</label>\
                      <input class="label" id="text_'+ type +'" name="form[fields_attributes]['+ serialize +'][field_name]" size="30" type="text" value='+ type +'>\
                      <input class="req" name="form[fields_attributes]['+ serialize +'][required]" type="radio" value="1">Yes\
                      <input class="req" name="form[fields_attributes]['+ serialize +'][required]" type="radio"value="1">No\
                      <span><strong>Required?</strong></span>\
                      <div><strong>Format</strong></div>\
                      <select  name="form[fields_attributes]['+ serialize +'][instructions]">\
                      	<option value="MM/DD/YY">MM/DD/YY</option>\
                      	<option value="DD/MM/YY">DD/MM/YY</option>\
                      <select>\
                      <input name="form[fields_attributes]['+ serialize +'][field_type]" size="30" type="hidden" value='+ type +'>\
                    </div>\
                    <div class="clear-both"></div></li>'
		formBuilder.append(html);
		}
				
	function textField(type,serialize) {
		html = '<li><div class="fields-left"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div>\
                      <label class="label">'+ type +'</label>\
                      <span class="required">*</span>\
                      <input type="text" readonly="readonly" disabled="disabled">\
                    </div>'
                    
         html += rightCol(type, serialize);
         
		formBuilder.append(html);
		}
		
	function textArea(type,serialize) {
		html = '<li><div class="fields-left"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div>\
                      <label class="label">Textarea</label>\
                      <span class="required">*</span>\
					<textarea spellcheck="true" rows="10" cols="50" readonly="readonly" disabled="disabled" ></textarea>\
				</div>'
				
		html += rightCol(type, serialize);
		
		formBuilder.append(html);
		}

	// acutal data this is input into the database	
	function rightCol(type, serialize){
		html = '<div class="fields-right origin '+ type +'">\
					  <img alt="White-left-arrow" class="left-arrow" src="/assets/white-left-arrow.png">\
					  <div class="form-closer fontello-icon-cancel-1"></div>\
                      <label >Field Label</label>\
                      <input class="label" id="text_'+ type +'" name="form[fields_attributes]['+ serialize +'][field_name]" size="30" type="text" value='+ type +'>\
                      <input class="req" name="form[fields_attributes]['+ serialize +'][required]" type="radio" value="1">Yes\
                      <input class="req" name="form[fields_attributes]['+ serialize +'][required]" type="radio"value="1">No\
                      <span><strong>Required?</strong></span>\
                      <div><strong>Instructions</strong></div>\
                      <textarea cols="40" name="form[fields_attributes]['+ serialize +'][instructions]" rows="10"></textarea>\
                      <input name="form[fields_attributes]['+ serialize +'][field_type]" size="30" type="hidden" value="'+ type +'">\
                    </div>\
                    <div class="clear-both"></div></li>'
          return html;
		}
		
		
		
	// Multi select form elements
	function fieldWithOptions(type,serialize) {
		html = '<li><div class="fields-left multi"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div>\
                      <label class="label">'+ type +'</label>\
                      <span class="required">*</span>\
                      <div id="multi-1" ><input type='+ type +' disabled="disabled" /><span>Choice One</span></div>\
					  <div id="multi-2" ><input type='+ type +' disabled="disabled" /><span> Choice Two</span></div>\
					  <div id="multi-3" ><input type='+ type +' disabled="disabled" /><span>Choice three</span></div>\
                    </div>'
                    
         html += rightColMulti(type, serialize);
         
		formBuilder.append(html);
		}
		
	function dropDown(type,serialize) {
		html = '<li><div class="fields-left multi"><div class="edit fontello-icon-edit"></div><div class="del fontello-icon-trash-4"></div>\
                      <label class="label">'+ type +'</label>\
                      <select disabled="disabled" >\
                      	<option>Choose Option</option>\
                      </select>\
                    </div>'
                    
         html += rightColMulti(type, serialize);
         
		formBuilder.append(html);
		}
		
	function dividerLine(type,serialize) {
		html = '<li><div class="fields-left divider"><div class="del"></div>\
                      <hr>\
                    </div>\
                    <div class="fields-right">\
                      <input name="form[fields_attributes]['+ serialize +'][field_type]" size="30" type="hidden" value="divider">\
                    </div>\
                    <div class="clear-both"></div></li>'

		formBuilder.append(html);
		}
		
		
	function rightColMulti(type, serialize){
		// set dropdown to radio for from input
		var radioType;
		if(type == 'dropdown') {
			radioType = 'radio'
			} else {
			radioType = type;
			}
		html = '<div class="fields-right multi-origin ' + type + '">\
				<img alt="White-left-arrow" class="left-arrow" src="/assets/white-left-arrow.png">\
				<div class="form-closer fontello-icon-cancel-1"></div>\
				<label >Field Label</label>\
				<input class="label" id="text_'+ type +'" name="form[fields_attributes]['+ serialize +'][field_name]" size="30" type="text" value='+ type +'>\
				<input class="req" name="form[fields_attributes]['+ serialize +'][required]" type="radio" value="1">Yes\
				<input class="req" name="form[fields_attributes]['+ serialize +'][required]" type="radio"value="1">No\
				<span><strong>Required?</strong></span>\
				<div><strong>Instructions</strong></div>\
				<textarea cols="40" name="form[fields_attributes]['+ serialize +'][instructions]" rows="10"></textarea>\
				<input name="form[fields_attributes]['+ serialize +'][field_type]" size="30" type="hidden" value='+ type +'>\
				<div class="multi-1"><label>Option</label>'
			if(type != "checkbox"){
				html +=	' <input type='+ radioType +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ serialize +'][selected]" />'
			}
				html +=	' <input class="keyup" data-type='+ type +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ serialize +'][option]" size="30" type="text" value="Choice One" /><a class="opt-add fontello-icon-plus-1"data-form='+ serialize +'></a>\
					<br /><label>Option Value</label> <input data-type='+ type +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ serialize +'][option_value]" size="30" type="text" value="Choice One Value" /></div>\
				<div class="multi-2">\
					<label>Option</label>'
			if(type != "checkbox"){
				html +=	' <input type='+ radioType +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ (serialize ) +'][selected]" />'
			}
				html += ' <input class="keyup" data-type='+ type +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ (serialize +1) +'][option]" size="30" type="text"value="Choice Two" /><a class="opt-add fontello-icon-plus-1"data-form='+ serialize +'></a><a class="opt-del fontello-icon-trash-4"></a>\
					<br /><label>Option Value</label> <input data-type='+ type +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ (serialize +1) +'][option_value]" size="30" type="text"value="Choice Two value" /></div>\
				<div class="multi-3" >\
					<label>Option</label>'
			if(type != "checkbox"){
				html +=	' <input type='+ radioType +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ (serialize ) +'][selected]" />'
			}
				html += ' <input class="keyup" data-type='+ type +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ (serialize +2) +'][option]" size="30" type="text"value="Choice Three" /><a class="opt-add fontello-icon-plus-1" data-form='+ serialize +'></a><a class="opt-del fontello-icon-trash-4"></a>\
					<br /><label> Option Value</label> <input data-type='+ type +' name="form[fields_attributes]['+ serialize +'][field_options_attributes]['+ (serialize +2) +'][option_value]" size="30" type="text"value="Choice Three Value" /></div>\
				</div>\
				<div class="clear-both"></div></li>'
          return html;
		}

	// right to right column copying and events
	fieldsLeft.live('click',function(){
		$(this).closest('li').siblings().find('.fields-right').hide();
		$(this).closest('li').siblings().find('.fields-left').removeClass('selected')
		$(this).toggleClass('selected');
		$(this).siblings('.fields-right').fadeToggle();
	});
	
	fieldsRightLabel.live('keyup',function(){
		inputVal = $(this).val();
		console.log(inputVal);
		$(this).closest('.fields-right').siblings('.fields-left').find('.label').html(inputVal);	
	});
	
	multiInput.live('focus', function(){
		var thisClass = $(this).closest('div').attr("class");
		$(this).keyup(function(){
			inputVal = $(this).val();
			console.log(inputVal);
			$(this).closest('.fields-right').siblings('.fields-left').find('#' + thisClass + '').find('span').html(inputVal);
			})
		})
	
	
	// radio button updating
	multiRadio.live('click',function(){
		var thisClass = $(this).closest('div').attr("class");
		
		//remove checked boxes if there are any
		$(this).closest('.fields-right').siblings('.fields-left').find('input[type="radio"]').prop("checked",false);
		
		//check the one in question
		$(this).closest('.fields-right').siblings('.fields-left').find('#' + thisClass + '').find('input[type="radio"]').attr("checked",true);
		
		// checks hidden false radio button
		$(this).closest('div').siblings().children('.no-radio').css('background', 'red');
		$(this).closest('div').siblings().children('input[type="radio"]').attr("checked",false);
		$(this).closest('div').siblings().children('.no-radio').children('input[type="radio"]').attr("checked",true);
		
		
		});
	
	// checkbox update	
	multiCheck.live('click',function(){
		var thisClass = $(this).closest('div').attr("class");
		var box =$(this).closest('.fields-right').siblings('.fields-left').find('#' + thisClass + '').find('input[type="checkbox"]')
		
		if(box.is(':checked')){
				box.attr("checked",false);
			} else {
				box.attr("checked",true);
			}
		if($(this).is(':checked')){
				$(this).siblings('.no-check').find('input[type="checkbox"]').attr("checked",false);
				$(this).siblings('.no-check').css('background','green');
				
			} else {
				$(this).siblings('.no-check').find('input[type="checkbox"]').attr("checked",true);
				$(this).siblings('.no-check').css('background','red');
			}
		});
	
	// select update
	multiSelect.live('click',function(){
		var inputVal = $(this).siblings('input').val();
		
		var thisClass = $(this).closest('div').attr("class");
		$(this).closest('.fields-right').siblings('.fields-left').find('option').html(inputVal);
		
		});
	// update text if choosen	
	multiSelectText.live('click',function(){
		var isChecked = $(this).siblings('input[type="radio"]').is(':checked'); 
		if(isChecked){
			$(this).keyup(function(){
				inputVal = $(this).val();
				console.log(inputVal);
				$(this).closest('.fields-right').siblings('.fields-left').find('option').html(inputVal);
			});
		}	
	});
	
	
	required.live('click',function(){
		$(this).closest('.fields-right').siblings('.fields-left').find('.required').toggle();
	});
	
	
	//delete field
	deleteField.live('click', function(){
		$(this).closest('li').remove();
	});
	
	// add options for multi selectors
	addOption.live('click', function(){
		var thisClass = $(this).parent('div').attr("class");
		var type = $(this).siblings('input[type="text"]').attr("data-type");
		var s = serial();
		var formId = $(this).siblings('input[type="text"]').attr('data-form');
		console.log(formId);
		var origin = originField(type, s, formId);
		$(this).parent('div').after(origin);
		
		var replicant = '<div id="multi-'+ s +'"><input type="'+ type +'" disabled="disabled"><span> </span></div>';
		
		$(this).closest('.fields-right').siblings('.fields-left').find('#' + thisClass + '').after(replicant);
		return false;
		})
	
	function originField(type, serialize, formId){
		var radioType;
			if(type == 'dropdown') {
				radioType = 'radio'
				} else {
				radioType = type;
				}
				
		var resource;
		if(formId != undefined) {
			resource = formId;
		} else {
			resource = 	serialize;
		}
		html = '<div class="multi-'+ serialize +'"><label>Option</label> '
			if (radioType != 'checkbox') {
                html += ' <input type='+ radioType +' name="form[fields_attributes]['+ resource +'][field_options_attributes]['+ serialize +'][selected]" />'
            }
                html += ' <input class="keyup" data-form='+ resource +' data-type='+ type +' name="form[fields_attributes]['+ resource +'][field_options_attributes]['+ serialize +'][option]" size="30" type="text"/><a class="opt-add fontello-icon-plus-1"></a><a class="opt-del fontello-icon-trash-4"></a>\
                 <br/><label>Option Value</label><input data-form='+ resource +' data-type='+ type +' name="form[fields_attributes]['+ resource +'][field_options_attributes]['+ serialize +'][option_value]" size="30" type="text"/></div>'
          return html;
		
		}
		
		function replicant(type, serialize){
			html = '<div id="multi-'+ serialize +'"><input type="'+ type +'" disabled="disabled"><span> </span></div>';
			return html;
		}
		
		// delete options for multi selectors
		deleteOption.live('click', function(){
			var thisClass = $(this).parent('div').attr("class");
			
			// remove replicant
			$(this).closest('.fields-right').siblings('.fields-left').find('#' + thisClass + '').remove();
			
			//remove parent
			$(this).parent('div').remove();
			
			//console.log(thisClass);
			$.post(this.href, { _method: 'delete' }, null, "script");
			return false;
		});
})

