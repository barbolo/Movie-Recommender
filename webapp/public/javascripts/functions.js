$(document).ready(function(){
	
	$('div#popcorn div.star').each(function(index, element){
		var val = index + 1;
		
		$(element).mouseover(function(){
			$('div#popcorn div.star').slice(0,val).addClass('popcorn_hover');
			$('div#rating .the_value').html(val);
			$('div#rating h3').addClass('color5');
		});
		
		$(element).mouseout(function(){
			$('div#popcorn div.star').slice(0,val).removeClass('popcorn_hover');
			$('div#rating h3').removeClass('color5');
			$('div#rating .the_value').html('');
		});
		
	});
	
	if ($('#q').val() == 'Search a 5-star movie') {
		$('#q').addClass('empty');
		$('#q').click(function(){
			$('#q').val('');
			$('#q').removeClass('empty');
		});
	}
	
});