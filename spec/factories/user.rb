FactoryBot.define do
    factory :user do
        # name { "Luiz" }
        email { "luiznew7@hotmail.com" }
        password { "123456" }
        password_confirmation { "123456" }
    end
end