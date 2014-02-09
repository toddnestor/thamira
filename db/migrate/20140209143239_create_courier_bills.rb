class CreateCourierBills < ActiveRecord::Migration
  def change
    create_table :courier_bills do |t|
      t.string :sender
      t.string :sender_mobile_no
      t.string :receiver
      t.string :receiver_mobile_no
      t.decimal :amount
      t.decimal :total
      t.string :bill_number
      t.references :user

      t.timestamps
    end
    add_index :courier_bills, :bill_number, unique: true
  end
end
