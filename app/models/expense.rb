class Expense < ApplicationRecord
	
	belongs_to :cycle, polymorphic: true
	belongs_to :expense_type
	belongs_to :owner, class_name: :User
	
	validates :title, presence: true
	validates :owner_id, presence: true
	validates :cycle_id, presence: true
	validates :cycle_type, presence: true

end
