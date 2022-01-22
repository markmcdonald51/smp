class AddZbodyToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :zbody, :binary
  end
end
