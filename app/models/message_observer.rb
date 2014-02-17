class MessageObserver < ActiveRecord::Observer

  def after_save(message)
    faye_channel = "/channels/#{message.channel.to_param}"
    # TODO move this to a rabl template
    broadcast_data = message.attributes.merge({:user => message.user.attributes.merge(message.user.userrealname)})
    Kandan::Config.broadcaster.broadcast(faye_channel, broadcast_data)
  end
end
