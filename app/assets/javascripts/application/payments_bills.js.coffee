payments_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#payments_bill_customer_name').val ''
		$('#payments_bill_service_name').val ''
		$('#payments_bill_network').val ''
		$('#payments_bill_mobile_number').val ''
		$('#payments_bill_amount').val ''
		$('#payments_bill_total').val ''
		$('#payments_bill_number_text').val ''
	# Fill Total Amount
	$('#payments_bill_amount').keyup ->
		amt = parseFloat($('#payments_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then (if (amt > 100) then (amt + 20) else (amt + 20)) else ''
		$('#payments_bill_total').val tot
$(document).ready(payments_ready)
$(document).on("page:load", payments_ready)