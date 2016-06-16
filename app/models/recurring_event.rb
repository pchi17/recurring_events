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
end
