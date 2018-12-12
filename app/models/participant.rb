class Participant < ApplicationRecord
	belongs_to :user, foreign_key: :participant_id
	belongs_to :cycle, class_name: "ExpenseCycle::SharedExpenseCycle"

	validates :cycle_id, presence: true
	validates :participant_id, presence: true, uniqueness: { scope: :cycle_id }
	
end