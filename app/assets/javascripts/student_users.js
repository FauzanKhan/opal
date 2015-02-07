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