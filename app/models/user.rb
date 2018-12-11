class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :expense_profile
  has_many :my_expense_types, class_name: :ExpenseType, foreign_key: :creator_id

  has_many :monthly_expenses, foreign_key: :owner_id, class_name: "Expense::ForwardExpense"
  has_many :recoverable_expenses, foreign_key: :owner_id, class_name: "Expense::RecoverableExpense"
  has_many :pending_expenses, foreign_key: :owner_id, class_name: "Expense::PendingExpense"
  has_many :monthly_expense_cycles, class_name: "ExpenseCycle::MainExpenseCycle", foreign_key: :owner_id
  has_many :participants, foreign_key: :participant_id
  has_many :shared_expense_cycles, lambda {
    where(type: 'ExpenseCycle::SharedExpenseCycle')
  }, through: :participants, source: :cycle

  validates :password, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :uname, presence: true, alpha_numeric_format: true


  after_create :add_expense_profile, :setup_monthly_cycle
    
  def add_expense_profile
    ExpenseProfile.create_for_user(self)
  end

  def setup_monthly_cycle
    ExpenseCycle::MainExpenseCycle.setup_for_user(self)
  end

  def get_current_cycle
    ExpenseCycle::MainExpenseCycle.get_current(self)
  end

  def get_past_cycles(options = {})
    ExpenseCycle::MainExpenseCycle.get_all_cycles(self,options)
  end

  def get_shared_cycles(options = {})
    ExpenseCycle::SharedExpenseCycle.get_all_cycles(self,options)
  end

  def get_my_expense_types
    ExpenseType.for_user(self)
  end

  def add_current_expense(params = {})
    ExpenseCycle::MainExpenseCycle.get_current(self).add_expense(self,params)
  end

  def update_current_expense(params = {})
    ExpenseCycle::MainExpenseCycle.expenses_for_user(self).find(params[:expense_id]).update_attribute(:total_spends,params[:spends])
  end

  def delete_current_expense(params = {})
    ExpenseCycle::MainExpenseCycle.expenses_for_user(self).find(params[:expense_id]).delete
  end

  def create_shared_cycle(params = {})
    ExpenseCycle::SharedExpenseCycle.create_for_user(self,params)
  end

  def add_shared_expense(params = {})
    ExpenseCycle::SharedExpenseCycle.find(params[:cycle_id]).add_expense_for_user(self,params)
  end

  def update_shared_expense(params = {})
    Expense::PendingExpense.where(:owner_id => id).find(params[:expense_id]).update_spends(params)
  end

  def delete_shared_expense(params = {})
    Expense::RecoverableExpense.where(:owner_id => id).find(params[:expense_id]).delete
  end

  def update_expense_profile(params = {})
    expense_profile.update_attributes(params.slice(:funds, :starts_at_day, :can_alert))
  end
  
end