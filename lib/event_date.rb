class EventDate < Date
  DAYS_IN_MONTH = {
    1  => 31,
    3  => 31,
    4  => 30,
    5  => 31,
    6  => 30,
    7  => 31,
    8  => 31,
    9  => 30,
    10 => 31,
    11 => 30,
    12 => 31
  }
  
  attr_reader :original_day
  
  def self.new(year, month, day)
    if month == 2
      max_days_in_month = leap?(year) ? 29 : 28
    else
      max_days_in_month = DAYS_IN_MONTH[month]
    end
    obj = super(year, month, [day, max_days_in_month].min)
    obj.instance_variable_set(:@original_day, day)
    return obj
  end
  
  def increment_months(x = 1)
    year_diff, new_month = (month + x).divmod(12)
    if new_month.zero?
      new_month = 12
      year_diff -= 1
    end
    EventDate.new(year + year_diff, new_month, original_day)
  end
  
  def is_business_day?
    !(is_weekend? || is_holiday?)
  end
  
  def is_weekend?
    saturday? || sunday?
  end
  
  def is_new_years_day?
    month == 1 && day == 1
  end
  
  def is_independence_day?
    month == 7 && day == 4
  end
  
  def is_veterans_day?
    month == 11 && day == 11
  end
  
  def is_christmas?
    month == 12 && day == 25
  end
  
  def is_thanksgiving?
    if month == 11 && thursday?
      return true if (self - 3.weeks).month == 11
    end
    return false
  end
  
  def is_memorial_day?
    if month == 5 && monday?
      return true if (self + 1.week).month == 6
    end
    return false
  end
  
  def is_holiday?
    return true if is_new_years_day?
    return true if is_memorial_day?
    return true if is_independence_day?
    return true if is_veterans_day?
    return true if is_thanksgiving?
    return true if is_christmas?
    return false
  end
end