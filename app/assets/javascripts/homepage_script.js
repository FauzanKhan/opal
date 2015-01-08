$(document).ready(function(){
	function goto_link(class_name, e){
			e.preventDefault();
			if(!($(class_name).hasClass('curr_active'))){
				$('.curr_active').css('display', 'none');
				$('.curr_active').removeClass('curr_active');
				$(class_name).css('display', 'block');
				$(class_name).addClass('zoomIn');
				$(class_name).addClass('curr_active');
			}
		}
		
		$('a.login_link').click(function(e){
			goto_link('.login_form_container', e);
		});
			
		$('a.student_signup_link').click(function(e){
			goto_link('.student_signup', e);
		});
			
		$('a.college_signup_link').click(function(e){
			goto_link('.college_signup', e);
		});
		
		$('a.intro_link').click(function(e){
			goto_link('.introduction', e);
		});
		
		$('a.forgot_password_link').click(function(e){
			goto_link('.forgot_password_form_container', e);
		});	

});
