FactoryGirl.define do
  factory :politician do
    sequence :name do |n|
      "Politician #{n}"
    end
    party "D"
    multiplier 1.5
    image "some image"
  end

  factory :outing do
    sequence :title do |n|
      "Outing #{n}"
    end
    description "some description"
    base_cost 50
    image_url "some image"
    politician
  end

  factory :user do
    sequence :name do |n|
      "Name #{n}"
    end
    sequence :email do |n|
      "email#{n}@email.com"
    end
    password 'password'
  end

  factory :order do
    status 0
    user
  end
end
