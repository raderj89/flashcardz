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



end
