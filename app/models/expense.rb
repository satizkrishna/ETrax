class Expense < ApplicationRecord
	
	belongs_to :expense_cycle, polymorphic: true
	has_one :expense_type
	belongs_to :owner, class_name: :User
	
end
