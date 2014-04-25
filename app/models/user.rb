class User < ActiveRecord::Base
  has_many :rounds

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password == password
      return user
    else
      nil
    end
  end
end
