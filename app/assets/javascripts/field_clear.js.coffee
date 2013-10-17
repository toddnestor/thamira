$ ->
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

