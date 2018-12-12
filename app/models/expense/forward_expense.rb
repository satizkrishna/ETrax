class Expense::ForwardExpense < Expense

	after_create :update_spends
	after_update :update_spends, :if => :total_spends_changed?
	after_destroy :update_spends

	validates :total_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }

	def self.create_for_user(user,params = {})
		new_expense = new
		new_expense.expense_type = ExpenseType.find_or_create_for_user(user,params[:type])
		new_expense.title = params[:type]
		new_expense.description = params[:description]
		new_expense.total_spends = params[:spends]
		new_expense.owner = user
		new_expense.cycle = user.get_current_cycle
		new_expense.save
	end
	
	def update_spends
		new_total = cycle.expenses.pluck(:total_spends).reduce(0,:+)
		cycle.update_attribute(:spends , new_total)
	end
end
