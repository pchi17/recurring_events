class EventDate < Date
    def is_business_day?
      !(is_weekend? || is_holiday?)
    end
    
    def is_weekend?
      saturday? || sunday?
    end
    
    def is_holiday?
      # I'm assuming there are only 4 holidays in a year.
      # New Year, July 4th, Veterans Day, and Christmas Day.
      return true if month == 1  && day == 1
      return true if month == 7  && day == 4
      return true if month == 11 && day == 11
      return true if month == 12 && day == 25
      return false
    end
end