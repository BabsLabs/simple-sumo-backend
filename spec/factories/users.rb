password = Faker::Internet.password

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 4) }
    email  { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end