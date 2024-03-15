FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    done { false }
    deadline { "2024-03-15 12:48:52" }
    user { nil }
  end
end
