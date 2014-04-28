class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :name, presence: true

  def choose_card
    (self.cards - cards_with_correct_guesses).sample
  end

  def cards_with_correct_guesses
    self.cards.joins(:guesses).where(guesses: { correct: true})
    # self.cards.find_by_sql("SELECT cards.* FROM cards
    #                         INNER JOIN guesses ON guesses.card_id = cards.id
    #                       WHERE guesses.correct = 't'")
  end

end
