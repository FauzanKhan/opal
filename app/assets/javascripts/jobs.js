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
        /*$.ajax({
            url: 'populate_branches',
            data: {course_id: $(this).val()},
            success: function(data, text){

            },
            error: function(xhr, textStatus, errorThrown){
                alert(+textStatus+"-"+errorThrown)
            }
        })*/
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
