FactoryBot.define do
  factory :user do
    name { "User Example" }
    email { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  
  factory :other_user, class: User do
    name { "OtherUser Example" }
    email { "other_user@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
