class Expense::PendingExpense < Expense
	
	belongs_to :parent, class_name: "Expense::RecoverableExpense"	
	
	validates :parent_id, presence: true
	validates :total_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :expected_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :recovered_spends, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
