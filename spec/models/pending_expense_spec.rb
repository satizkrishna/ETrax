require 'rails_helper'

RSpec.describe Expense::PendingExpense, type: :model do
  	before(:all) { 
		@user = create(:user) 
		@cycle = create(:shared_expense_cycle,owner_id: @user.id)
		@expense_type = create(:expense_type,creator_id: @user.id)
		@recoverable_expense = create(:recoverable_expense,owner_id: @user.id,cycle_id: @cycle.id,expense_type_id: @expense_type.id)
		@pending_expense = build(:recoverable_expense,owner_id: @user.id,cycle_id: @cycle.id,expense_type_id: @expense_type.id,parent_id: @recoverable_expense.id)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:owner_id) }
		it { should validate_presence_of(:cycle_id) }
		it { should validate_presence_of(:parent_id) }
		it { should validate_presence_of(:cycle_type) }
		it { should validate_presence_of(:total_spends) }
		it { should validate_numericality_of(:total_spends) }
		it { should validate_presence_of(:expected_spends) }
		it { should validate_numericality_of(:expected_spends) }
		it { should validate_presence_of(:recovered_spends) }
		it { should validate_numericality_of(:recovered_spends) }
	end

	context "has proper associations" do
		it { should belong_to(:owner) }
		it { should belong_to(:cycle) }
		it { should belong_to(:expense_type) }
		it { should belong_to(:parent) }
	end

	context "has proper values, when created with proper values," do		
		it { expect(@pending_expense).to_not be(nil) }
		it { expect(@pending_expense).to be_valid }
	end

end
