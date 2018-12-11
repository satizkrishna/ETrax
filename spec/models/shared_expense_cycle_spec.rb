require 'rails_helper'

RSpec.describe ExpenseCycle::SharedExpenseCycle, type: :model do
  	before(:all) { 
		@user = create(:user) 
		@shared_expense_cycle = build(:shared_expense_cycle,owner_id: @user.id)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:owner_id) }
	end

	context "has proper associations" do
		it { should belong_to(:owner) }
		it { should have_many(:expenses) }
		it { should have_many(:participants) }
		it { should have_many(:participating_users) }
	end

	context "has proper values, when created with proper values," do		
		it { expect(@shared_expense_cycle).to_not be(nil) }
		it { expect(@shared_expense_cycle).to be_valid }
	end

end
