

function showTabla(flag){
	if(flag){
		jQuery(".overlay-container").css("top", jQuery(window).scrollTop());

		jQuery('.overlay-container').fadeIn(function(){
			window.setTimeout(function(){
				jQuery('.window-container').addClass('window-container-visible');
			}, 100);
		});
        }else
		jQuery('.overlay-container').fadeOut().end().find('.window-container').removeClass('window-container-visible');
}

function showTablaByID(IDName){
	jQuery("#" + IDName).css("top", jQuery(window).scrollTop());

	jQuery("#" + IDName).fadeIn(function(){
		window.setTimeout(function(){
			jQuery('.window-container').addClass('window-container-visible');
		}, 100);
	});
}