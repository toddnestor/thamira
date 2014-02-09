courier_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#courier_bill_sender').val ''
		$('#courier_bill_sender_mobile_no').val ''
		$('#courier_bill_receiver').val ''
		$('#courier_bill_receiver_mobile_no').val ''
		$('#courier_bill_amount').val ''
		$('#courier_bill_total').val ''
		$('#courier_bill_number_text').val ''
	# Fill Total Amount
	$('#courier_bill_amount').keyup ->
		amt = parseFloat($('#courier_bill_amount').val())
		tot = if (amt != "" && !isNaN(amt) ) then (amt) else ''
		$('#courier_bill_total').val tot
$(document).ready(courier_ready)
$(document).on("page:load", courier_ready)