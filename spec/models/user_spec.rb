require 'rails_helper'

RSpec.describe User, type: :model do
 		
	context "has proper validations" do
		it { should validate_presence_of(:uname) }
		it { should validate_presence_of(:email) }
		it { should validate_presence_of(:password) }
		it { should validate_uniqueness_of(:email).case_insensitive }
	end

	before { @user = create(:user) }

	context "has proper values" do
		it { expect(@user.uname.match /^[\w\s-]*$/).to be_an_instance_of(MatchData) }
		it { expect(@user.email.match /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).to be_an_instance_of(MatchData) }
	end

	context "has proper associations" do
		it { should have_one(:expense_profile) }
		it { should have_many(:my_expense_types) }
		it { should have_many(:monthly_expense_cycles) }
		it { should have_and_belong_to_many(:shared_expense_cycles) }
	end

end
