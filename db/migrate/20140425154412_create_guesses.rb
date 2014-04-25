class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.belongs_to :round
      t.boolean :correct, default: false
    end
  end
end
