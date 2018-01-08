class CreateCompanyGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :company_galleries do |t|
      t.string :image
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
