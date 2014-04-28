class Card < ActiveRecord::Base
  belongs_to :deck
  has_many :guesses, dependent: :destroy
end
