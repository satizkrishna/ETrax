require 'rails_helper'

RSpec.describe ExpenseProfile, type: :model do
	before(:all) { 
		@user = build(:user) 
		@expense_profile = build(:expense_profile,user_id: @user.id)
		@expense_profile_overflow = build(:expense_profile, :overflowing_starts_at_day, user_id: @user.id)
		@expense_profile_negative = build(:expense_profile, :negative_funds, user_id: @user.id)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:starts_at_day) }
		it { should validate_presence_of(:funds) }
		it { should validate_numericality_of(:starts_at_day) }
		it { should validate_numericality_of(:funds) }
	end
end
