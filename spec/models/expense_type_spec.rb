require 'rails_helper'

RSpec.describe ExpenseType, type: :model do
	before(:all) { 
		@user = build(:user) 
		@expense_type = build(:expense_type,creator_id: @user.id)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:title) }
		it { expect(@expense_type).to validate_uniqueness_of(:title).scoped_to(:creator_id) }
	end

	context "has proper associations" do
		it { should belong_to(:creator) }
	end

end
