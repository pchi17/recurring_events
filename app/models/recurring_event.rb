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
  
  private
    def set_default_values
      self.start_date ||= Time.now
      self.interval_months ||= 1
      self.deliver_buffer_days ||= 0
    end
end
