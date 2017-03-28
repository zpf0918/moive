class AddFilmIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :film_id, :integer
  end
end
