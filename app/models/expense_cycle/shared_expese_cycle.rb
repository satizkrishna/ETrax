class ExpenseCycle::SharedExpenseCycle < ExpenseCycle

	has_many :expenses, as: :expense_cycle	
	has_many :participants, class_name: :User, through: :participants, foreign_key: :shared_expense_cycle_id
end
