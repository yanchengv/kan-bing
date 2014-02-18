class Kandan.Views.Chatbox extends Backbone.View

  template: JST['chatbox']
  tagName: 'div'
  className: 'chatbox-area'

  events:
    "keypress .chatbox": 'postMessage'

  postMessage: (event)->

    if event.keyCode== 13

      $chatbox = $(".chatbox")
      content = $chatbox.val()
      message = new Kandan.Models.Message({
        'content':    content,
        'channel_id': $chatbox.data('active_channel_id')
      })

      message.save({},{success: ()->
        console.log "posted! enjoy your day"
      })
      #let faye.js do this
      #document.getElementById("chatbox").value = ''
      0


  render: ->
    $(@el).html(@template())
    @


