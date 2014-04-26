class Guess < ActiveRecord::Base
  belongs_to :round

  def set_correct
    self.correct = true
    self.save
  end
end
