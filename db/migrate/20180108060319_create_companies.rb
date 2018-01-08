class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.json :company_logo
      t.text :short_description
      t.text :description
      t.boolean :is_seen, default: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
