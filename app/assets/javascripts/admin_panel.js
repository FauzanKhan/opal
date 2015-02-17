function add_branch(branch_count){
	var branch_name_field = '<input class="form-control" style="width:80%;display:inline-block;" type="text" name="course[branches_attributes]['+branch_count
							+'][name]" id="course_branches_attributes_'+branch_count+'_name">'
	var destroy_branch_checkbox = '<label class="control-label" for="course_branches_attributes_'+branch_count
								  +'__destroy"><input name="course[branches_attributes]['+branch_count
								  +'][_destroy]" type="hidden" value="0"><input type="checkbox" value="1" name="course[branches_attributes]['+branch_count
								  +'][_destroy]" id="course_branches_attributes_'+branch_count+'__destroy">Destroy</label>'
	$('#branch_fields').append(branch_name_field);
	$('#branch_fields').append(destroy_branch_checkbox);

}

$('#add_branch').click(function(){
	var branch_count = $('#branch_fields input.form-control').length
	add_branch(branch_count);
})