module UsersHelper
    def am_pm(hour)
        meridian = (hour >= 12) ? 'pm' : 'am'
        hour = case hour
              when 0, 12
                12
              when 13 .. 23
                hour - 12
              else
                hour
              end
      
        "#{ hour } #{ meridian }"
      end
end
