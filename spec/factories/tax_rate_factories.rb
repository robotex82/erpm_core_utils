FactoryGirl.define do
  factory :tax_rate do
    sequence(:name) { |i| "Tax Rate ##{i}" }
    rate 0.19
    live_from 5.minutes.ago
    # valid_to Date.new(9999, 12, 31)
  end
end
