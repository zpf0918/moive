class ChangePostColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :film_integer
  end
end
