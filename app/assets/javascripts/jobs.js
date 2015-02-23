$('.dates input').datepicker({
    format: "D, dd M yyyy",
    startDate: "today",
    orientation: "top right",
    calendarWeeks: true,
    todayHighlight: true
});

$('#select_all_courses_container').on('change', 'input[type="checkbox"]', function(){
    if($(this).is(':checked')){
        $('.courses_selection input[type="checkbox"]').each(function(){
          this.checked = false;
          $(this).trigger('change');
          this.checked = true;
          $(this).trigger('change');
        });
    }
    else{
        $('.courses_selection input[type="checkbox"]').each(function(){
          this.checked = false;
          $(this).trigger('change');  
        });
    }
});

$('#select_all_branches_container').on('change', 'input[type="checkbox"]', function(){
    if($(this).is(':checked')){
        $('.branches_selection .dynamic_branches_container input[type="checkbox"]').each(function(){
          this.checked = true;
        });
    }
    else{
        $('.branches_selection .dynamic_branches_container input[type="checkbox"]').each(function(){
          this.checked = false;
        });
    }
});

$('.courses_selection').on('change', 'input[type="checkbox"]', function(){
    select_all_courses();
    if($(this).is(':checked')){
        $.ajax({
            url: 'populate_branches',
            data: {course_id: $(this).val()},
            success: function(data, text){
                $('#select_all_branches_container').show();
                $('.branches_selection .message').hide();
                $('#select_all_branches').prop('checked', false);
            },
            error: function(xhr, textStatus, errorThrown){
                alert(textStatus+"-"+errorThrown)
            }

        })
    }
    else{
        var course_id = $(this).val();
        $('.branches_selection input[type="checkbox"]').each(function(){
            if($(this).attr('data-course') == course_id){
                $(this).closest('.branches').remove();
                if($('.dynamic_branches_container').is(':empty')){
                    $('.branches_selection .message').show();
                    $('#select_all_branches_container').hide();
                }
            }
        });
        $('#select_all_courses').attr('checked', false);
    }
    
});

$('.branches_selection .dynamic_branches_container').on('change', 'input[type="checkbox"]', function(){
    if($(this).is(':checked')){
        select_all_branches();
    }
    else{
        $('#select_all_branches').attr('checked', false);
    }
    
});

function shortlist_student(student_id, jobpost_id, link){
        $.ajax({
            url: '/jobposts/shortlist_applicant',
            data: {applicant_id: student_id,
                   jobpost_id: jobpost_id},
            beforeSend: function(){
                $(link).siblings('.ajax_overlay').show();
            },
            success: function(data, text){
                $(link).siblings('.ajax_overlay').hide();
                $(link).removeClass('undecided');
                $(link).attr('data-original-title', 'shortlisted');
            },
            error: function(xhr, textStatus, errorThrown){
                $(link).siblings('.ajax_overlay').hide();
                alert(+textStatus+"-"+errorThrown)
            }
        })
    }
    function select_student(student_id, jobpost_id, link){
        $.ajax({
            url: '/jobposts/select_applicant',
            data: {applicant_id: student_id,
                   jobpost_id: jobpost_id},
            beforeSend: function(){
                $(link).siblings('.ajax_overlay').show();
            },
            success: function(data, text){
                $(link).siblings('.ajax_overlay').hide();
                $(link).removeClass('undecided');
                $(link).attr('data-original-title', 'selected');
            },
            error: function(xhr, textStatus, errorThrown){
                $(link).siblings('.ajax_overlay').hide();
                alert(+textStatus+"-"+errorThrown)
            }
        })
    }

    function select_all_courses(){
        if ($('.courses_selection input[type="checkbox"]:checked').length == $('.courses_selection input[type="checkbox"]').length) {
            $('#select_all_courses').prop('checked', true);
        }
    }

    function select_all_branches(){
        if ($('.dynamic_branches_container input[type="checkbox"]:checked').length == $('.dynamic_branches_container input[type="checkbox"]').length) {
            $('#select_all_branches').prop('checked', true);
        }
    }

    $('.application_table_container table tr').on('click','a.shortlist.undecided', function(){
        var link = $(this);
        var student_id = $(this).closest('tr.student_info').attr('id');
        var jobpost_id = $(this).closest('table.application_table').attr('id');
        shortlist_student(student_id, jobpost_id, link)
    })

    $('.application_table_container table tr').on('click','a.select.undecided', function(){
        var link = $(this);
        var student_id = $(this).closest('tr.student_info').attr('id');
        var jobpost_id = $(this).closest('table.application_table').attr('id');
        select_student(student_id, jobpost_id, link)
    })

    $('[data-toggle="tooltip"]').tooltip();

    if(!($('.dynamic_branches_container').is(':empty'))){
        $('#select_all_branches_container').show();
    }

    select_all_courses();
    select_all_branches();