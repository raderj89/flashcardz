class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :user
      t.belongs_to :deck
      t.integer :num_correct, default: 0
      t.integer :num_wrong, default: 0
      t.timestamps
    end
  end
end
