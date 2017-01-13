class MessagesController < ApplicationController
    before_action :logged_in_user
    before_action :get_messages

  def index
      @skip_footer = true
      @users = User.all.take(4)
  end

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast 'chatroom_channel',
                                    message: render_message(message)

      head :ok
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
      render(partial: 'messages/message_entry', object: message, as: 'message')
    end

    
end

