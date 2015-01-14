$(document).ready(function(){
	
		var window_height = $(window).height();
		var window_width = $(window).width();
		
		function doc_width_adjust(){
			if(window_height > 500 && window_width > 1000){
				$('.window_span').css('height', window_height+'px');//.css('width', window_width+'px');
				$('.intro_wrapper .container').css('height', window_height+'px');
			}
			else{
				$('.window_span').css('height', 900+'px');//.css('width', window_width+'px');
				$('.intro_wrapper .container').css('height', 900+'px');
			}

			if($('.form_container').height() >( ($('.window_span').height())-100)){
				$('.window_span').css('height', 1000+'px');//.css('width', window_width+'px');
				$('.intro_wrapper .container').css('height', 1000+'px');
			}
		}
		
		doc_width_adjust();

		$(document).on('page:load', function() {
    		doc_width_adjust();
		});
		
		$(window).resize(function(){
			window_height = $(window).height();
			window_width = $(window).width();
			doc_width_adjust()
		});
		
	});