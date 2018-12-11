class ExpenseCycle::SharedExpenseCycle < ExpenseCycle

	has_many :expenses, as: :cycle	
	has_many :participants, foreign_key: :cycle_id
	has_many :participating_users, class_name: :User, through: :participants, source: :user

	validates :title, presence: true
	validates :owner_id, presence: true
end
