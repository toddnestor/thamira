enquiry_ready = ->
	# Clear Fields
	$('.clear_button').click ->
		$('#enquiry_customer_name').val ''
		$('#enquiry_service_name').val ''
		$('#enquiry_mobile_number').val ''
		$('#enquiry_bill_number_text').val ''
$(document).ready(enquiry_ready)
$(document).on("page:load", enquiry_ready)