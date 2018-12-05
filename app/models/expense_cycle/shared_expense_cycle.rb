class ExpenseCycle::SharedExpenseCycle < ExpenseCycle

	has_many :expenses, as: :expense_cycle	
	has_and_belongs_to_many :participants, class_name: :User, join_table: :participants, foreign_key: :shared_expense_cycle_id
end
