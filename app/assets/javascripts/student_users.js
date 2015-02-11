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

	if($('.experience_wrapper .experience').length > 1){
		$('.experience_wrapper .experience:last').remove();
	}
	
	var experience_count = $('.experience_wrapper .experience').length//Math.ceil(experience_ids.length/2)//education_ids.substr(education_ids.lenth-1, 1);
	function add_experience(){
		var experience_content = '<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-building"></span></div>'+
								'<input type="text" name="student[experiences_attributes]['+
								experience_count+'][company_name]" class="form-control" placeholder="Company" id="student_experiences_attributes_'+
								experience_count+'_company_name" data-toggle="tooltip" data-placement="top" title="Comapny Name" />'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-briefcase"></span></div>'+
								'<input type="text" name="student[experiences_attributes]['+
								experience_count+'][position]" class="form-control" placeholder="Position" id="student_experiences_attributes_'+
								experience_count+'_position" data-toggle="tooltip" data-placement="top" title="Role" />'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-calendar-o"></span></div>'+
								'<input type="text" name="student[experiences_attributes]['+
								experience_count+'][start_date]" class="form-control date" placeholder="From" id="student_experiences_attributes_'+
								experience_count+'_start_date" data-toggle="tooltip" data-placement="top" title="Role" />'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-6 col-md-6">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-calendar"></span></div>'+
								'<input type="text" name="student[experiences_attributes]['+
								experience_count+'][end_date]" class="form-control date" placeholder="To" id="student_experiences_attributes_'+
								experience_count+'_end_date" data-toggle="tooltip" data-placement="top" title="Role" />'+
							'</div>'+
						'</div>'+
						'<div class=" col-lg-12">'+
							'<div class="form-group">'+
								'<label for="student_experiences_attributes_'+
								experience_count+'_contributions" class="control-label">Contributions</label>'+
								'<textarea class="form-control" name="student[experiences_attributes]['+
								experience_count+'][contributions]" id="student_experiences_attributes_'+
								experience_count+'_contributions" ></textarea>'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-12">'+
						'<input type="hidden" value="false" name="student[experiences_attributes]['+
								experience_count+'][_destroy]" id="student_experiences_attributes_'+experience_count+'__destroy">'+
						'<a class="btn btn-md btn-danger pull-right" id="remove_experience">'+
							'<span class="fa fa-remove"></span> Remove'+
						'</a></div>'
		$('.experience_container').append('<div class="experience"></div>');
		$('.experience_container .experience:last').append(experience_content);
		experience_count++;
		update_date_picker();
		$('[data-toggle="tooltip"]').tooltip();
		if($('.experience_container .experience:visible').length >= 6 ){
			$('#add_experience').hide();
			$('#experience_limit_reached').show();
		}
	}

	function remove_experience(exp){
		$(exp).parent().parent().hide();
		$(exp).prev('input[type="hidden"]').val('1');
		if($('.experience_container .experience:visible').length < 6 ){
			$('#add_experience').show();
			$('#experience_limit_reached').hide();
		}
	}

	$('.student_info_element').on('click', '#add_experience',add_experience);

	$('.student_info_element').on('click', '#remove_experience',function(){
		remove_experience($(this));
	});

	update_date_picker();

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

	var education_count = $('table.prev_education tbody tr').length//Math.ceil(education_ids.length/2)//education_ids.substr(education_ids.lenth-1, 1);
	$('table.prev_education tbody tr:last').remove();
	function add_schools(){
		var college = '<td width="38%">'+
						'<input type="text" name="student[educations_attributes]['+
						education_count+'][institute]" id="students_educations_attributes_'+
						education_count+'_institute" placeholder="College/Board" class="form-control institute" />'+
						'</td>';
		var degree = '<td width="37%">'+
						'<input type="text" name="student[educations_attributes]['+
						education_count+'][degree]" id="students_educations_attributes_'+
						education_count+'_degree" placeholder="UG/Secondary/High School" class="form-control degree" />'+
						'</td>';
		var percentage = '<td width="12%">'+
						'<input type="text" name="student[educations_attributes]['+
						education_count+'][percentage]" id="students_educations_attributes_'+
						education_count+'_percentage" placeholder="%" class="form-control percentage" />'+
						'</td>';
		var year_of_passing = '<td width="12%">'+
						'<input type="text" name="student[educations_attributes]['+
						education_count+'][year_of_passing]" id="students_educations_attributes_'+
						education_count+'_year_of_passing" placeholder="20XX" class="form-control year_of_passing" />'+
						'</td>';
		var remove_btn = '<td width="20%">'+
							'<input type="hidden" value="false" name="student[educations_attributes]['+
							education_count+'][_destroy]" id="student_educations_attributes_'+education_count+'__destroy">'+
							'<a class="remove_edu_row btn btn-sm btn-danger">x</a></td>';

		$('table.prev_education tbody').append('<tr></tr>');
		$('table.prev_education tbody tr:last').append(college);
		$('table.prev_education tbody tr:last').append(degree);
		$('table.prev_education tbody tr:last').append(percentage);
		$('table.prev_education tbody tr:last').append(year_of_passing);
		$('table.prev_education tbody tr:last').append(remove_btn);
		//update_row_ids();
		education_count++;
		if($('table.prev_education tbody tr:visible').length >= 3){
			$('#add_schools').hide();
			$('#degree_limit_reached').show();
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

	if($('.project_wrapper .project').length > 1){
		//$('.project_wrapper .project:last').remove();
	}
	var project_count = $('.project_wrapper .project').length
	add_project()
	function add_project(){
		var project_content = '<div class="col-lg-12">'+
							'<div class="input-group">'+
								'<div class="input-group-addon"><span class="fa fa-file-code-o"></span></div>'+
								'<input type="text" name="student[projects_attributes]['+
								project_count+'][name]" class="form-control" placeholder="Project Name" id="student_projects_attributes_'+
								project_count+'_name" data-toggle="tooltip" data-placement="top" title="Name" />'+
							'</div>'+
						'</div>'+
						'<div class=" col-lg-12">'+
							'<div class="form-group">'+
								'<label for="student_projects_attributes_'+
								project_count+'_description" class="control-label">Description</label>'+
								'<textarea class="form-control" name="student[projects_attributes]['+
								project_count+'][description]" id="student_projects_attributes_'+
								project_count+'_description" ></textarea>'+
							'</div>'+
						'</div>'+
						'<div class="col-lg-12">'+
						'<input type="hidden" value="false" name="student[project_attributes]['+
								project_count+'][_destroy]" id="student_project_attributes_'+project_count+'__destroy">'+
						'<a class="btn btn-md btn-danger pull-right" id="remove_project">'+
							'<span class="fa fa-remove"></span> Remove'+
						'</a></div>'
		$('.project_container').append('<div class="project"></div>');
		$('.project_container .project:last').append(project_content);
		project_count++;
		$('[data-toggle="tooltip"]').tooltip();
		if($('.project_container .project:visible').length >= 6 ){
			$('#add_project').hide();
			$('#project_limit_reached').show();
		}
	}

	function remove_project(pro){
		$(pro).parent().parent().hide();
		$(pro).prev('input[type="hidden"]').val('1');
		if($('.project_container .project:visible').length < 6 ){
			$('#add_project').show();
			$('#project_limit_reached').hide();
		}
	}

	$('.project_wrapper').on('click', '#remove_project',function(){
		debugger;
		remove_project($(this));
	});

	$('.project_wrapper').on('click', '#add_project', function(){
		add_project();
	})

	$('[data-toggle="tooltip"]').tooltip();

});
