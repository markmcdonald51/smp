class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.references :site, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.string :teaser_img_url
      t.string :title
      t.text :body
      t.date :date_published
      t.string :native_id
      t.string :native_page_url
      t.string :native_image_url

      t.timestamps
    end
  end
end
