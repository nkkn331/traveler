class RenameTitteColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :titte, :title
  end
end
