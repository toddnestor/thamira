class CreateClothsBills < ActiveRecord::Migration
  def change
    create_table :cloths_bills do |t|
      t.string :customer_name
      t.string :service_name
      t.string :model
      t.string :mobile_number
      t.decimal :amount
      t.decimal :total
      t.string :bill_number
      t.references :user, index: true

      t.timestamps
    end
  end
end
