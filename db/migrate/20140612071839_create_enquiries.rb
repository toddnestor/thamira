class CreateEnquiries < ActiveRecord::Migration
  def change
  	create_table :enquiries do |t|
  	  t.string :customer_name
      t.string :service_name
      t.string :mobile_number
      t.string :bill_number
      t.references :user, index: true

      t.timestamps
    end

    add_index :enquiries, :bill_number, unique: true
  end
end
