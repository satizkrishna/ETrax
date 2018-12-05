class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :expense_profile
  has_many :my_expense_types, class_name: :ExpenseType, foreign_key: :creator_id

  has_many :monthly_expense_cycles, class_name: "ExpenseCycle::MainExpenseCycle", foreign_key: :owner_id
  has_and_belongs_to_many :shared_expense_cycles, class_name: "ExpenseCycle::SharedExpenseCycle", join_table: :participants, foreign_key: :participant_id

  validates :uname, :email, :password, presence: true
  validates :email, uniqueness: true

  
end
