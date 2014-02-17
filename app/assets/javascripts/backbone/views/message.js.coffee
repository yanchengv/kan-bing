class Kandan.Views.Message extends Backbone.View
  template: JST['message']

  tagName: 'p'
  className: 'message'

  render: ()->

    $(@el).html(@template({message: @options.message}))
    @