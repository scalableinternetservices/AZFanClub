module PollsHelper
    def tryParseDatetime(source, end_of_day = false) 
        if source.present?
            begin 
                date =  DateTime.parse(source)
                if end_of_day
                    return date.end_of_day
                else 
                    return date
                end
            rescue ArgumentError
                return ""
            end
        end
        return ""
    end
end
