#=require ../../consultation/chat/mCustomScrollbarconcat
class Kandan.Helpers.Channels

  @messageContainer: ()->
    $("#messagebox .mCSB_container")

  @messagebox: ()->
    $("#messagebox")

  @add_message: (message_attributes)->
    message = new Kandan.Models.Message(message_attributes)
    message_view  = new Kandan.Views.Message({message: message})
    @messageContainer().append(message_view.render().el)
    @messagebox().mCustomScrollbar("update")
    @messagebox().mCustomScrollbar("scrollTo","bottom")