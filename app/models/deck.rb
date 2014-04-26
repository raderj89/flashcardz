class Deck < ActiveRecord::Base
  has_many :cards
  has_many :rounds

  def choose_card
    (self.cards - cards_with_correct_guesses).sample
  end

  def cards_with_correct_guesses
    self.cards.find_by_sql("SELECT * FROM cards
                            INNER JOIN guesses ON cards.id = guesses.card_id
                           WHERE guesses.correct != 'true'")
  end

  def remove_card(card_id)
    self.cards.find(card_id).delete
  end
end
