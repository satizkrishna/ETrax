FactoryBot.define do
  
  factory :user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    uname { Faker::Name.first_name }
  end

end
