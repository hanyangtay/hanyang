App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    scroll_bottom()
    submit_message()

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.type is 'message'
      if $('.message-send').attr('id') is "#{data.user_id}"
        $('.chat-messages-container').append data.message
      else
        $('.chat-messages-container').append data.message2
      scroll_bottom()
    else if data.type is 'online'
      $('.chat-online-all').append data.message

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('.message-send').click()
      event.target.value = ""
      event.preventDefault()
      
scroll_bottom = () ->
  $('.chat-messages-container').scrollTop($('.chat-messages-container')[0].scrollHeight)
  
  