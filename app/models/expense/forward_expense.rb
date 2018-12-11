class Expense::ForwardExpense < Expense
	validates :total_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	
end
