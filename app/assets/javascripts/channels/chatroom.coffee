App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    $(".chat-wrapper").load()
    $(".messages-load").removeClass('messages-load')
    $(".chat-online-all").load()
    $('.mdl-spinner').removeClass('is-active')
    scroll_bottom()
    submit_message()

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.type is 'online'
      unless $("#online-user-#{data.user_id}").length 
        $(".chat-online-all").append data.message
    else if data.type is 'offline'
       $("#online-user-#{data.user_id}").remove()
    else
      if $('.message-send').attr('id') is "#{data.user_id}"
        $('.chat-messages-container').append data.message
      else
        $('.chat-messages-container').append data.message2
      scroll_bottom()
  
  
  
submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('.message-send').click()
      event.target.value = ""
      event.preventDefault()
      
scroll_bottom = () ->
  $('.chat-messages-container').scrollTop($('.chat-messages-container')[0].scrollHeight)
  
  