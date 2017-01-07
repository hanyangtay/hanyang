module ApplicationHelper
    
    def error_message(object)
        flash[:danger] = object.errors.full_messages.first.gsub("\'", "no")
    end
    
    def error_message_now(object)
        flash.now[:danger] = object.errors.full_messages.first.gsub("\'", "no")
    end
    
end
