class Expense::RecoverableExpense < Expense
	has_one :parent, class_name: "Expense::ForwardExpense"
end
