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

require 'rails_helper'

RSpec.describe RecurringEvent, type: :model do
  subject { build(:recurring_event) }
  
  it 'has a valid factory' do
    expect(subject).to be_valid
  end
  
  describe 'validations' do
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_length_of(:name).is_at_most(250) }
    it { expect(subject).to validate_presence_of :start_date }
    it { expect(subject).to validate_numericality_of(:interval_months).is_greater_than(0) }
    it { expect(subject).to validate_inclusion_of(:day_of_month).in_range(1..31) }
    it { expect(subject).to validate_numericality_of(:deliver_buffer_days).is_greater_than_or_equal_to(0) }
  end
  
  describe '#set_default_values' do
    it 'sets default values when none are passed in' do
      event = RecurringEvent.new
      expect(event.start_date).to_not be_nil
      expect(event.interval_months).to eq(1)
      expect(event.deliver_buffer_days).to eq(0)
    end
  end
end
