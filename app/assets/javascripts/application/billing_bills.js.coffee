billing_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#billing_bill_customer_name').val ''
		$('#billing_bill_service_name').val ''
		$('#billing_bill_mobile_number').val ''
		$('#billing_bill_amount').val ''
		$('#billing_bill_total').val ''
		$('#billing_bill_number_text').val ''
	# Fill Total Amount
	$('#billing_bill_amount').keyup ->
		amt = parseFloat($('#billing_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then (if (amt > 100) then (amt + 0) else (amt + 0)) else ''
		$('#billing_bill_total').val tot
$(document).ready(billing_ready)
$(document).on("page:load", billing_ready)