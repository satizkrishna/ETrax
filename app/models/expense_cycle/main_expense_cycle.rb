class ExpenseCycle::MainExpenseCycle < ExpenseCycle

	has_many :expenses, as: :cycle


	validates :title, presence: true
	validates :owner_id, presence: true
	validates :starts_at, :expires_at, presence: true
	validates :spends, numericality: { greater_than_or_equal_to: 0 }

end
