50.times do |i|
  Task.create!(title: "Blog#{i+1}", content: "テスト")
end
