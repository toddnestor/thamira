service_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#service_bill_customer_name').val ''
		$('#service_bill_service_name').val ''
		$('#service_bill_model').val ''
		$('#service_bill_mobile_number').val ''
		$('#service_bill_amount').val ''
		$('#service_bill_total').val ''
		$('#service_bill_number_text').val ''
	# Fill Total Amount
	$('#service_bill_amount').keyup ->
		amt = parseFloat($('#service_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then (if (amt > 100) then (amt + 10) else (amt + 5)) else ''
		$('#service_bill_total').val tot
$(document).ready(service_ready)
$(document).on("page:load", service_ready)