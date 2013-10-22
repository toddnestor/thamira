ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#eb_bill_service_name').val ''
		$('#eb_bill_service_number').val ''
		$('#eb_bill_mobile_number').val ''
		$('#eb_bill_amount').val ''
		$('#eb_bill_total').val ''
		$('#eb_bill_number_text').val ''
	$('#eb_bill_amount').keyup ->
		amt = parseFloat($('#eb_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then amt + 5 else ''
		$('#eb_bill_total').val tot
	# Date Picker
	$('#date_picker').datepicker
	    format: "dd/mm/yyyy"
	    startDate: "01/01/2013"
	    autoclose: true
	    todayHighlight: true
	# Print And Save
	$('print_save_button').click ->
		if $('#bill_search').val() == ""
			alert "Bill Number is Empty!"
			false
	# Export Button on Empty Date
	$('#export_button').click ->
		if $('#date_picker').val() == ""
			alert "Select a Date to Export Bills"
			false
$(document).ready(ready)
$(document).on("page:load", ready)