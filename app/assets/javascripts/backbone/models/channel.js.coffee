class Kandan.Models.Channel extends Backbone.Model
  urlRoot: ()->
    "/channels/#{@channel_id}"

  initialize: (id)->
    @channel_id = id

  parse: (response)->
    messages = new Kandan.Collections.Messages()
    messages.add(response.messages)
    @messages = messages
    response