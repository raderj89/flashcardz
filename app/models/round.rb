class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :user
  belongs_to :deck

  def increase_correct
    self.num_correct += 1
    self.save
  end

  def cards_left
    self.deck.cards.length - self.deck.cards_with_correct_guesses.length
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

  def calculate_score
    ((self.num_correct / (self.deck.cards.length + self.num_wrong).to_f) * 100).to_i.to_s + '%'
  end


end
