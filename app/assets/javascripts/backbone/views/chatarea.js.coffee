class Kandan.Views.ChatArea extends Backbone.View

  template: JST['chatarea']
  # className: 'channel'


  render: ->

    $(@el).html(@template())
    view = new Kandan.Views.ListMessages({channel: @options.channel})
    $(@el).append(view.render().el)
    #$(@el).attr('id', 'Scroller')
    @