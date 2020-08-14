class AddPhotoUrlToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :photo_url, :string
  end
end
