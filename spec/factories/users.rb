FactoryBot.define do
  factory :admin_user, class: User do
    name { "adminsさん" }
    email { "adminadmino@piyopiyo.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { true }
  end

  factory :normal_user, class: User do
    name { "normalさん" }
    email { "normalnormal@piyopiyo.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end

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
