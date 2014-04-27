class AddImagesToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :image_url, :string, default: "https://content.etilize.com/images/400/11970387.jpg"
  end
end
