class ExpenseCycle::MainExpenseCycle < ExpenseCycle

	has_many :expenses, as: :expense_cycle
	belongs_to :owner, class_name: :User

end
