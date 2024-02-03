FactoryBot.define do
    factory :user do
        # name { "Luiz" }
        # email { "luiznew7@hotmail.com" }
        email {Faker::Internet.email}
        password { "123456" }
        password_confirmation { "123456" }
    end
end