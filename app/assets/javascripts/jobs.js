$('.dates input').datepicker({
    format: "D, dd M yyyy",
    startDate: "today",
    orientation: "top right",
    calendarWeeks: true,
    todayHighlight: true
});

$('.courses_selection').on('change', 'input[type="checkbox"]', function(){
    if($(this).is(':checked')){
        $.ajax({
            url: 'populate_branches',
            data: {course_id: $(this).val()},
            success: function(data, text){

            },
            error: function(xhr, textStatus, errorThrown){
                alert(+textStatus+"-"+errorThrown)
            }

        })
    }
    else{
        var course_id = $(this).val();
        $('.branches_selection input[type="checkbox"]').each(function(){
            if($(this).attr('data-course') == course_id){
                $(this).parent().remove();
                if($('.branches_selection label.checkbox-inline').length == 0){
                    $('.branches_selection .message').show();
                }
            }
        })
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