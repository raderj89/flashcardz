class Deck < ActiveRecord::Base
  has_many :cards
  has_many :rounds

  def choose_card
    self.cards.sample
  end
end
