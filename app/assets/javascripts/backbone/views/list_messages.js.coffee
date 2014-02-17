class Kandan.Views.ListMessages extends Backbone.View
  tagName: 'div'
  # className: 'messages'

  render: ()->
    for message in @options.channel.messages.models
      message_view = new Kandan.Views.Message({message: message})
      $(@el).append(message_view.render().el)
    $(@el).attr('id', "messagebox")
    $(@el).attr('class', "content")
    $(@el).data('channel_id', @options.channel.get('id'))
    @