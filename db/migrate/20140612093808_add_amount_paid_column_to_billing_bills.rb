class AddAmountPaidColumnToBillingBills < ActiveRecord::Migration
	def change
		add_column :billing_bills, :amount_paid, :decimal
	end
end
