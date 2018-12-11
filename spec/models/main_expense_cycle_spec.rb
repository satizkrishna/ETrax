require 'rails_helper'

RSpec.describe ExpenseCycle::MainExpenseCycle, type: :model do
  	before(:all) { 
		@user = create(:user) 
		@main_expense_cycle = build(:main_expense_cycle,owner_id: @user.id)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:owner_id) }
		it { should validate_presence_of(:expires_at) }
		it { should validate_presence_of(:starts_at) }
		it { should validate_numericality_of(:spends) }
	end

	context "has proper associations" do
		it { should belong_to(:owner) }
		it { should have_many(:expenses) }
	end

	context "has proper values, when created with proper values," do		
		it { expect(@main_expense_cycle).to_not be(nil) }
		it { expect(@main_expense_cycle).to be_valid }
	end

end
