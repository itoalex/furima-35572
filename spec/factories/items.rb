FactoryBot.define do
  factory :item do
    name          { Faker::Name.name }
    describe      { Faker::Lorem.sentence }
    category_id      { 1 }
    status_id        { 1 }
    ship_fee_id      { 1 }
    area_id          { 1 }
    day_id           { 1 }
    price         { 300 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user
  end
end
