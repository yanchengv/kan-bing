class Kandan.Models.Message extends Backbone.Model
  urlRoot: ()->
    "/channels/#{@get('channel_id')}/messages"

  initialize: (options)->
    @channel_id = @get('channel_id')