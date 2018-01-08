class CreateCompanyAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :company_addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
