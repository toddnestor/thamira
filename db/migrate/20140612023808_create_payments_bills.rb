class CreatePaymentsBills < ActiveRecord::Migration
  def change
    create_table :payments_bills do |t|
      t.string :customer_name
      t.string :service_name
      t.string :network
      t.string :mobile_number
      t.decimal :amount
      t.decimal :total
      t.string :bill_number
      t.references :user, index: true

      t.timestamps
    end

    add_index :payments_bills, :bill_number, unique: true
  end
end
