class Deck < ActiveRecord::Base
  has_many :cards
  has_many :rounds

  def choose_card
    (self.cards - cards_with_correct_guesses).sample
  end



  def cards_with_correct_guesses
    #self.cards.joins(:guesses).where(guesses: { correct: true})
    self.cards.find_by_sql("SELECT cards.* FROM cards
                            INNER JOIN guesses ON guesses.card_id = cards.id
                          WHERE guesses.correct = 't'")
  # SELECT * FROM cards
  #   INNER JOIN guesses ON guesses.card_id = cards.id
  # WHERE cards.deck_id = 2 AND guesses.correct = 'true'

  # SELECT "cards".* FROM "cards"
  #   INNER JOIN "guesses" ON "guesses"."card_id" = "cards"."id"
  # WHERE "cards"."deck_id" = 2 AND "guesses"."correct" = 't'

  end

  def cards_with_incorrect_guesses
    self.cards.find_by_sql("SELECT * FROM cards
                            INNER JOIN guesses ON cards.id = guesses.card_id
                           WHERE guesses.correct = 'false'")
  end

end
