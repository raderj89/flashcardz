class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :user
  belongs_to :deck

  def increase_correct
    self.num_correct += 1
    self.save
  end

  def increase_wrong
    self.num_wrong += 1
    self.save
  end

  def game_over?
    if self.deck.cards_with_correct_guesses.length == self.deck.cards.length
      return true
    else
      nil
    end
  end
end
