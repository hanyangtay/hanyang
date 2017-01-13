App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.message.blank?
    $("#all-messages").append("<%= escape_javascript(render(partial: 'messages/message_entry', object: data.message, as: 'message')) %>");
      $('#messages').append data.message
        
$(document).on 'turbolinks:load', ->
  submit_message()

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('input').click()
      event.target.value = ""
      event.preventDefault()