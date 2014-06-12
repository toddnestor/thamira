cloths_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#cloths_bill_customer_name').val ''
		$('#cloths_bill_service_name').val ''
		$('#cloths_bill_model').val ''
		$('#cloths_bill_mobile_number').val ''
		$('#cloths_bill_amount').val ''
		$('#cloths_bill_total').val ''
		$('#cloths_bill_number_text').val ''
	# Fill Total Amount
	$('#cloths_bill_amount').keyup ->
		amt = parseFloat($('#cloths_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then (if (amt > 100) then (amt + 10) else (amt + 5)) else ''
		$('#cloths_bill_total').val tot
$(document).ready(cloths_ready)
$(document).on("page:load", cloths_ready)