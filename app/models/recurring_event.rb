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

class RecurringEvent < ActiveRecord::Base
  validates :name,       presence: true, length: { maximum: 250 }
  validates :start_date, presence: true
  validates :interval_months,     numericality: { greater_than: 0 }
  validates :deliver_buffer_days, numericality: { greater_than_or_equal_to: 0 }
  validates :day_of_month, inclusion: { in: 1..31 }
  
  after_initialize :set_default_values
  
  def next_due_date
    next_four_event_dates.first.due_date
  end
  
  def next_delivery_date
    next_four_event_dates.first.delivery_date
  end
  
  def first_calculated_date
    if day_of_month < start_date.day
      date = start_date + 1.month
      EventDate.new(date.year, date.month, day_of_month)
    else
      EventDate.new(start_date.year, start_date.month, day_of_month)
    end
  end
  
  def next_four_event_dates
    results = []
    calculated_date = first_calculated_date
    until results.count == 4
      dates = EventDates.new(calculated_date, deliver_buffer_days)
      if dates.due_date > Date.today && dates.due_date > start_date
        results << dates
        calculated_date = calculated_date.increment_months(interval_months)
      else
        calculated_date = calculated_date.increment_months
      end
    end
    results
  end
  
  private
    def set_default_values
      self.start_date ||= Date.today
      self.interval_months ||= 1
      self.deliver_buffer_days ||= 0
    end
end
