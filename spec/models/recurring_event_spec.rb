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
  
  describe '#next_due_date' do
    context 'when calculated date is SUNDAY July 3 2016 and buffer is 0 days' do
      it 'finds next_due_date to be July 1 2015' do
        recurring_event = build(:recurring_event, start_date: Date.today, day_of_month: 3, deliver_buffer_days: 0)
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 3))
        expect(recurring_event.next_due_date).to eq(EventDate.new(2016, 7, 1))
      end
    end
    
    context 'when calculated date is SUNDAY July 3 2016 and buffer is 3 days' do
      it 'finds next_due_date to be June 28 2016' do
        recurring_event = build(:recurring_event, start_date: Date.today, day_of_month: 3, deliver_buffer_days: 3)
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 3))
        expect(recurring_event.next_due_date).to eq(EventDate.new(2016, 6, 28))
      end
    end
    
    context 'when calculated date is INDEPENDENCE DAY! July 4 2016 and buffer is 0 days' do
      it 'finds next_due_date to be July 1 2016' do
        recurring_event = build(:recurring_event,
          start_date: Date.today, day_of_month: 4, deliver_buffer_days: 0
        )
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 4))
        expect(recurring_event.next_due_date).to eq(EventDate.new(2016, 7, 1))
      end
    end
    
    context 'when calculated date is INDEPENDENCE DAY! July 4 2016 and buffer is 5 days' do
      it 'finds next_due_date to be June 24 2016' do
        recurring_event = build(:recurring_event,
          start_date: Date.today, day_of_month: 4, deliver_buffer_days: 5
        )
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 4))
        expect(recurring_event.next_due_date).to eq(EventDate.new(2016, 6, 24))
      end
    end
    
    context 'when calculated date is FRIDAY July 8 2016 and buffer is 0 days' do
      it 'finds next_due_date to be July 8 2016' do
        recurring_event = build(:recurring_event,
          start_date: Date.today, day_of_month: 8, deliver_buffer_days: 0
        )
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 8))
        expect(recurring_event.next_due_date).to eq(EventDate.new(2016, 7, 8))
      end
    end
    
    context 'when calculated date is FRIDAY July 8 2016 and buffer is 4 days' do
      it 'finds next_due_date to be July 1 2016' do
        recurring_event = build(:recurring_event,
          start_date: Date.today, day_of_month: 8, deliver_buffer_days: 4
        )
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 8))
        expect(recurring_event.next_due_date).to eq(EventDate.new(2016, 7, 1))
      end
    end
  end
  
  describe '#next_delivery_date' do
    context 'when calculated date is SUNDAY July 3 2016' do
      it 'finds next_delivery_date to be FRIDAY July 1 2015' do
        recurring_event = build(:recurring_event, start_date: Date.today, day_of_month: 3)
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 3))
        expect(recurring_event.next_delivery_date).to eq(EventDate.new(2016, 7, 1))
      end
    end
    
    context 'when calculated date is INDEPENDENCE DAY! July 4 2016' do
      it 'finds next_due_date to be July 1 2016' do
        recurring_event = build(:recurring_event, start_date: Date.today, day_of_month: 4)
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 4))
        expect(recurring_event.next_delivery_date).to eq(EventDate.new(2016, 7, 1))
      end
    end
    
    context 'when calculated date is FRIDAY July 2016' do
      it 'finds next_due_date to be July 8 2016' do
        recurring_event = build(:recurring_event, start_date: Date.today, day_of_month: 8)
        expect(recurring_event.first_calculated_date).to eq(EventDate.new(2016, 7, 8))
        expect(recurring_event.next_delivery_date).to eq(EventDate.new(2016, 7, 8))
      end
    end
  end
end
