require 'rails_helper'

RSpec.describe User, type: :model do
	
	before(:all) { 
		@user = build(:user) 
		@user_with_crpt_email = build(:user,:incorrect_email)
		@user_with_crpt_uname = build(:user,:incorrect_uname)
	} 		

	context "has proper validations" do
		it { should validate_presence_of(:uname) }
		it { should validate_presence_of(:email) }
		it { should validate_presence_of(:password) }
		it { should validate_uniqueness_of(:email).case_insensitive }
	end

	context "has proper associations" do
		it { should have_one(:expense_profile) }
		it { should have_many(:my_expense_types) }
		it { should have_many(:monthly_expense_cycles) }
		it { should have_many(:shared_expense_cycles).through(:participants) }
	end
	
	context "has proper values, when created with proper values," do		
		it { expect(@user.uname.match /^[\w\s-]*$/).to_not be(nil) }
		it { expect(@user.email.match /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).to_not be(nil) }
		it { expect(@user).to be_valid }
	end

	context "has no corrupted data, when created with corrupted values," do
		it { expect(@user_with_crpt_email.email.match /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).to be(nil) }
		it { expect(@user_with_crpt_email).to be_invalid }
		it { expect(@user_with_crpt_uname).to be_invalid }
	end

end
