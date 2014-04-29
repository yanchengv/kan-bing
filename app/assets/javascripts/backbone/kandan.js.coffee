#= require_self
#= require_tree ../../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers
#= require_tree ./helpers
#= require_tree ./broadcasters
window.Kandan =
  Models:      {}
  Collections: {}
  Views:       {}
  Routers:     {}
  Helpers:      {}
  Broadcasters: {}
  Data:         {}

  init:(channel_id) ->

    #chat_area = new Kandan.Views.ChatArea(channel_id)
    #$('.container').html(chat_area.render().el)
    channel = new Kandan.Models.Channel(channel_id)
    channel.fetch({success: ()=>
      chat_area = new Kandan.Views.ChatArea({channel: channel})
      $('.chatcontainer').html(chat_area.render().el)

      chatbox = new Kandan.Views.Chatbox()
      $('.chatbox_container').html(chatbox.render().el)

      # TODO move broadcast subscription to a helper
      # TODO change this to use the broadcaster from the settings
      # TODO set as global to debug. remove later.
      window.broadcaster = new Kandan.Broadcasters.FayeBroadcaster()
      window.broadcaster.subscribe "/channels/#{channel.get('id')}"

      # TODO move this to a helper
      $('.chatbox').data('active_channel_id',
                         channel_id)
      $('.chatbox').attr('id', "chatbox")
      $('.chatbox').attr('placeholder','请在此输入...')
    })

