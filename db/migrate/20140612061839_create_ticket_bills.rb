class CreateTicketBills < ActiveRecord::Migration
  def change
  	create_table :ticket_bills do |t|
  	  t.string :customer_name
      t.string :service_name
      t.string :mobile_number
      t.string :ticket_number
      t.decimal :amount
      t.decimal :total
      t.string :bill_number
      t.references :user, index: true

      t.timestamps
    end

    add_index :ticket_bills, :bill_number, unique: true
  end
end
