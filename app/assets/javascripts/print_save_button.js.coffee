$ ->
	$('print_save_button').click ->
		if $('#bill_search').val() == ""
			alert "Bill Number is Empty!"
			false