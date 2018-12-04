class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :expense_profile
  has_many :my_expense_types, class_name: :ExpenseType, foreign_key: :creator_id
  
end
