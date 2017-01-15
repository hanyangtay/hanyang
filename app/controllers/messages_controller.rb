class MessagesController < ApplicationController
    before_action :logged_in_user
    before_action :get_messages

  def index
      @skip_footer = true
      @users = User.where(online: true)
  end

  def create
    message = current_user.messages.build(message_params)
    if message.save
      message_full = render_message(message)
      message_rendered=message_full.split("!@#$%^")
      ActionCable.server.broadcast 'chatroom_channel',
                                    type: 'message',
                                    user_id: message.user.id,
                                    message: message_rendered[0],
                                    message2: message_rendered[1]
    end
  end

  private
  
    def message_params
      params.require(:message).permit(:content)
    end
    
    def get_messages
      @messages = Message.for_display
      @message  = current_user.messages.build
    end
    
    def render_message(message)
        render(partial: 'messages/message_full', object: message, as: 'message')
    end

    
end

