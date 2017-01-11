module ApplicationHelper
    
    def error_message(object)
        object.errors.full_messages.each do |msg|
        flash[:danger] = msg.html_safe
        end
    end
    
    def error_message_now(object)
        object.errors.full_messages.each do |msg|
        flash.now[:danger] = msg.html_safe
        end
    end
    
end
