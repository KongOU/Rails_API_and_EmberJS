class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :website
      t.text :address
      t.string :customer_id
      t.text :additional_info

      t.timestamps
    end
  end
end
