class Expense::RecoverableExpense < Expense

	has_many :pending_expenses, class_name: "Expense::PendingExpense", foreign_key: :parent_id , dependent: :destroy

	validates :total_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :expected_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :recovered_spends, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
