require 'rails_helper'

RSpec.describe Participant, type: :model do
	before(:all) { 
		@user = create(:user) 
		@cycle = create(:shared_expense_cycle,owner_id: @user.id)
		@participant = build(:participant,participant_id: @user.id,cycle_id: @cycle.id)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:cycle_id) }
		it { should validate_presence_of(:participant_id) }
		it { expect(@participant).to validate_uniqueness_of(:participant_id).scoped_to(:cycle_id) }
	end

	context "has proper associations" do
		it { should belong_to(:user) }
		it { should belong_to(:cycle) }
	end

	context "has proper values, when created with proper values," do		
		it { expect(@participant).to_not be(nil) }
		it { expect(@participant).to be_valid }
	end

end
