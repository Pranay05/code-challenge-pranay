FactoryBot.define do
  factory :company do
    name                         { Faker::Name.name }
    zip_code                     { Faker::Address.zip_code(state_abbreviation: 'CA').to_s  }
    phone                        { Faker::PhoneNumber.cell_phone }
    email                        { Faker::Name.first_name  + "@getmainstreet.com" }
  end

  factory :invalid_company do
    name                         nil
    zip_code                     { Faker::Address.zip_code(state_abbreviation: 'CA').to_s  }
    phone                        { Faker::PhoneNumber.cell_phone }
    email                        { Faker::Name.first_name  + "@abc.com" }
  end

end