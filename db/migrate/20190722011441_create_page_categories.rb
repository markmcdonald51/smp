class CreatePageCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :page_categories do |t|
      t.references :page, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
