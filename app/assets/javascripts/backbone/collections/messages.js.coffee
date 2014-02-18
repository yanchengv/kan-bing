class Kandan.Collections.Messages extends Backbone.Collection

  urlRoot: ()->
    "/channels/#{@channel_id}/messages"

  initialize: (options)->
    @channel_id = @get('channel_id')
