class CreateEbBills < ActiveRecord::Migration
	def change
		create_table :eb_bills do |t|
			t.string :service_name
			t.string :service_number
			t.string :mobile_number
			t.decimal :amount
			t.decimal :total
			t.string :bill_number
			t.references :user
			t.timestamps
		end
		add_index :eb_bills, :bill_number, unique: true
	end
end
