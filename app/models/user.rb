class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :expense_profile
  has_many :my_expense_types, class_name: :ExpenseType, foreign_key: :creator_id

  has_many :monthly_expense_cycles, class_name: "ExpenseCycle::MainExpenseCycle", foreign_key: :owner_id
  has_and_belongs_to_many :shared_expense_cycles, class_name: "ExpenseCycle::SharedExpenseCycle", join_table: :participants, foreign_key: :participant_id

  validates :password, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :uname, presence: true, alpha_numeric_format: true

  after_create :add_expense_profile, :setup_monthly_cycle
  
  def add_expense_profile
    # ExpenseProfile.create_for_user(self)
  end

  def setup_monthly_cycle
    # ExpenseCycle::MainExpenseCycle.setup_for_user(self)
  end

  def get_current_cycle
    # ExpenseCycle::MainExpenseCycle.get_current(self)
  end

  def get_past_cycles(options = {})
    # ExpenseCycle::MainExpenseCycle.get_all_cycles(self,options)
  end

  def get_shared_cycles
    # ExpenseCycle::SharedExpenseCycle.get_all_cycles(self)
  end

  def get_my_expense_types
    # ExpenseType.for_user(self)
  end
  
end
