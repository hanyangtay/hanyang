class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    message_user.is_online
    stream_from "chatroom_channel"
    

  end

  def unsubscribed
    message_user.is_offline
    
  end
end
