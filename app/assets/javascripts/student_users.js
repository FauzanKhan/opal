function pop_branches(){
    $.ajax({
        url: 'populate_branches',
        data: {course_id: $('#student_course_id').val()},
        success: function(data, text){

        },
        error: function(xhr, textStatus, errorThrown){
            alert(+textStatus+"-"+errorThrown)
        }

    })
}

$(document).ready(function(){

	function update_date_picker(){
		$('input.date').datepicker({
		    format: "dd M yyyy",
		    orientation: "top right",
		    calendarWeeks: true,
		    todayHighlight: true
		});
	}

	/*function add_experience(){
		var experience_content = '<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-building"></span></div>'+
								'<input type="text" class="form-control" placeholder="Company" data-toggle="tooltip" data-placement="top" title="Comapny Name" />'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-briefcase"></span></div>'+
								'<input type="text" class="form-control" placeholder="Position" data-toggle="tooltip" data-placement="top" title="Role" />'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-calendar-o"></span></div>'+
								'<input type="text" class="form-control date" placeholder="From" data-toggle="tooltip" data-placement="top" title="Start Date" />'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-calendar"></span></div>'+
								'<input type="text" class="form-control date" placeholder="To" data-toggle="tooltip" data-placement="top" title="End Date"/>'+
							'</div>'+
						'</div>'+
						'<div class=" col-lg-12">'+
							'<div class="form-group">'+
								'<label class="control-label">Contributions</label>'+
								'<textarea class="form-control"></textarea>'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-12"><a class="btn btn-md btn-danger pull-right" id="remove_experience">'+
							'<span class="fa fa-remove"></span> Remove'+
						'</a></div>'
		$('.experience_container').append('<div class="experience"></div>');
		$('.experience_container .experience:last').append(experience_content);
		update_date_picker()
		if($('.experience_container .experience').length == 6 ){
			$('#add_experience').hide();
			$('#experience_limit_reached').show();
		}
	}

	function remove_experience(exp){
		$(exp).parent().parent().remove();
		if($('.experience_container .experience').length <= 6 ){
			$('#add_experience').show();
			$('#experience_limit_reached').hide();
		}
	}*/

	/*function update_row_ids(){
		var row_id = 0;
		$('table.prev_education tbody tr').each(function(){
			debugger;
			$(this).find('input.institute').attr('name', 'student[educations_attributes]['+row_id+'][institute]');
			$(this).find('input.degree').attr('name', 'student[educations_attributes]['+row_id+'][degree]');
			$(this).find('input.percentage').attr('name', 'student[educations_attributes]['+row_id+'][percentage]');
			$(this).find('input.year_of_passing').attr('name', 'student[educations_attributes]['+row_id+'][year_of_passing]');
			row_id++;
		})
	}*/

	var education_ids = $('#student_education_ids').val();
	var education_count = Math.ceil(education_ids.length/2)//education_ids.substr(education_ids.lenth-1, 1);
	var a = education_count+1;
	$('table.prev_education tbody tr:last').remove();
	function add_schools(){
		if($('table.prev_education tbody tr:visible').length >= 3){
			$('#add_schools').hide();
			$('#degree_limit_reached').show();
		}
		else{
			var college = '<td width="38%">'+
							'<input type="text" name="student[educations_attributes]['+
							a+'][institute]" id="students_educations_attributes_'+
							a+'_institute" placeholder="College/Board" class="form-control institute" />'+
							'</td>';
			var degree = '<td width="37%">'+
							'<input type="text" name="student[educations_attributes]['+
							a+'][degree]" id="students_educations_attributes_'+
							a+'_degree" placeholder="UG/Secondary/High School" class="form-control degree" />'+
							'</td>';
			var percentage = '<td width="12%">'+
							'<input type="text" name="student[educations_attributes]['+
							a+'][percentage]" id="students_educations_attributes_'+
							a+'_percentage" placeholder="%" class="form-control percentage" />'+
							'</td>';
			var year_of_passing = '<td width="12%">'+
							'<input type="text" name="student[educations_attributes]['+
							a+'][year_of_passing]" id="students_educations_attributes_'+
							a+'_year_of_passing" placeholder="20XX" class="form-control year_of_passing" />'+
							'</td>';
			var remove_btn = '<td width="20%">'+
								'<input type="hidden" value="false" name="student[educations_attributes]['+
								a+'][_destroy]" id="student_educations_attributes_'+a+'__destroy">'+
								'<a class="remove_edu_row btn btn-sm btn-danger">x</a></td>';

			$('table.prev_education tbody').append('<tr></tr>');
			$('table.prev_education tbody tr:last').append(college);
			$('table.prev_education tbody tr:last').append(degree);
			$('table.prev_education tbody tr:last').append(percentage);
			$('table.prev_education tbody tr:last').append(year_of_passing);
			debugger;
			$('table.prev_education tbody tr:last').append(remove_btn);
			//update_row_ids();
			a++;
		}
	}

	$('.student_info_element').on('click', '#add_schools', function(){
		add_schools();	
	});

	$('.student_info_element').on('click', '.remove_edu_row', function(){
		$(this).prev('input[type="hidden"]').val('1');
		$(this).parent().parent().hide();
		//update_row_ids();
		if(($('#add_schools').is(':hidden'))){
			$('#add_schools').show();
			$('#degree_limit_reached').hide();
		}
	});

	$('.student_info_element').on('click', '#add_experience',add_experience);

	$('.student_info_element').on('click', '#remove_experience',function(){
		remove_experience($(this));
	});

	update_date_picker();

	$('[data-toggle="tooltip"]').tooltip();

});
