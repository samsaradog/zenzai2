require './lib/user_validator'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me,
#                  :is_admin, :gets_daily_dharma
  # attr_accessible :title, :body
  #

  validates :is_admin, :inclusion => [true, false]
  validates :gets_daily_dharma, :inclusion => [true, false]

  validates_with UserValidator

end
