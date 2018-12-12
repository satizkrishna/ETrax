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

	context "has proper associations" do
		it { should belong_to(:user) }
	end

	context "has proper values, when created with proper values," do		
		it { expect(@expense_profile).to_not be(nil) }
		it { expect(@user).to be_valid }
	end

	context "has no corrupted data, when created with corrupted values," do
		it { expect(@expense_profile_overflow).to be_invalid }
		it { expect(@expense_profile_negative).to be_invalid }
	end
end
