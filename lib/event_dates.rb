class EventDates
  attr_reader :calculated_date, :delivery_date, :due_date, :buffer_days
  
  def initialize(calculated_date, buffer_days = 0)
    @buffer_days     = buffer_days
    @calculated_date = calculated_date
  end
  
  def delivery_date
    date = calculated_date
    date -= 1.day until date.is_business_day?
    date
  end
  
  def due_date
    date = delivery_date - buffer_days.days
    date -= 1.day until date.is_business_day?
    date
  end
end