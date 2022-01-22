class AddBioToAuthor < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :bio, :text
  end
end
