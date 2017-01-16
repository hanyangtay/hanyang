class ChatroomChannel < ApplicationCable::Channel
  
  def subscribed
    message_user.is_online
    stream_from "chatroom_channel"
    ActionCable.server.broadcast 'chatroom_channel',
                                    type: 'online',
                                    user_id: message_user.id,
                                    message: render_message(message_user)
  end

  def unsubscribed
    message_user.is_offline
    ActionCable.server.broadcast 'chatroom_channel',
                                    type: 'offline',
                                    user_id: message_user.id
  end
  
  private

    def render_message(message_user)
        ApplicationController.renderer.render(partial: 'messages/online_entry', object: message_user, as: 'user')
    end
end
