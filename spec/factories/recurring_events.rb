# == Schema Information
#
# Table name: recurring_events
#
#  id                  :integer          not null, primary key
#  name                :string(250)      not null
#  start_date          :datetime         not null
#  interval_months     :integer          not null
#  day_of_month        :integer          not null
#  deliver_buffer_days :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :recurring_event do
    name                { Faker::Lorem.sentence.slice(0..249) }
    start_date          { rand(1..10).days.from_now }
    interval_months     { rand(1..3) }
    day_of_month        { rand(1..31) }
    deliver_buffer_days { rand(5) }
  end
end
