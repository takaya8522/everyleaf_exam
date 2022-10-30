FactoryBot.define do
  factory :label do
    name { "test" }
  end

  factory :first_label, class: Label do
    name { 'test1' }
    user_id { }
  end

  factory :second_label, class: Label do
    name { 'test2' }
    user_id { }
  end
end
