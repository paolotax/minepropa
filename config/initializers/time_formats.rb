Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%a, %b %e alle %l:%M") + time.strftime("%p").downcase }