ticket_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#ticket_bill_customer_name').val ''
		$('#ticket_bill_service_name').val ''
		$('#ticket_bill_ticket_number').val ''
		$('#ticket_bill_mobile_number').val ''
		$('#ticket_bill_amount').val ''
		$('#ticket_bill_total').val ''
		$('#ticket_bill_number_text').val ''
	# Fill Total Amount
	$('#ticket_bill_amount').keyup ->
		amt = parseFloat($('#ticket_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then (if (amt >= 100) then (amt + 8) else (amt + 4)) else ''
		$('#ticket_bill_total').val tot
$(document).ready(ticket_ready)
$(document).on("page:load", ticket_ready)