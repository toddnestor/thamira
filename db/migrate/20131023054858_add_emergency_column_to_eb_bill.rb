class AddEmergencyColumnToEbBill < ActiveRecord::Migration
	def change
		add_column :eb_bills, :emergency, :boolean
	end
end
