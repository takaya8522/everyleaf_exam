# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # 「task」のように実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを作成されます
  factory :task do
    title { '書類作成' }
    content { '企画書を作成する。' }
    created_at { '2025/02/19' }
    deadline_on { '2025/02/18' }
    priority { 1 }
    status { 0 }
    user_id { 1 }
  end
  # 作成するテストデータの名前を「second_task」とします
  # 「second_task」のように存在しないクラス名をつける場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要がります
  factory :first_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
    created_at { '2025/02/18' }
    deadline_on { '2025/02/18' }
    priority { 1 }
    status { 0 }
    user_id {  }
  end

  factory :second_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
    created_at { '2025/02/17' }
    deadline_on { '2025/02/17' }
    priority { 2 }
    status { 1 }
    user_id {  }
  end

  factory :third_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
    created_at { '2025/02/16' }
    deadline_on { '2025/02/16' }
    priority { 0 }
    status { 2 }
    user_id {  }
  end

  factory :association_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
    created_at { '2025/02/16' }
    deadline_on { '2025/02/16' }
    priority { 0 }
    status { 2 }
    user_id {  }
    association :label
  end
end