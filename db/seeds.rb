User.create!(name: "test", email: "test0001@example.com, password_digest: 123456, admin: true")
User.create!(name: "test1", email: "test0002@example.com, password_digest: 123456, admin: false")

50.times do |i|
  Task.create!(title: "first_task", content: "テスト", deadline_on: "2025/02/18", priority: 1, status: 0, user_id: 1)
end

50.times do |i|
  Task.create!(title: "second_task", content: "テスト", deadline_on: "2025/02/17", priority: 2, status: 1, user_id: 2)
end