FactoryBot.define do
  factory :first_user, class: User do
    name { "piyopiyo" }
    email { "piyopiyo@piyopiyo.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end

  factory :second_user, class: User do
    name { "piyopiyo太郎" }
    email { "piyopiyotaro@piyopiyo.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { true }
  end
end
