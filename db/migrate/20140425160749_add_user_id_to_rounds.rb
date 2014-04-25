class AddUserIdToRounds < ActiveRecord::Migration
  def change
    add_index :rounds, :user_id
    add_index :rounds, :deck_id
  end
end
