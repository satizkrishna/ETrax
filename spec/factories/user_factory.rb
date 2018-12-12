FactoryBot.define do
  
  factory :user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    uname { Faker::Name.first_name }


    trait :incorrect_email do
      email { "aaa.com" }
    end

    trait :incorrect_uname do
      uname { "satzrock*" }
    end

  end

end
