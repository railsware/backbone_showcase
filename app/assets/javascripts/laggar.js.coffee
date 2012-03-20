window.Laggar =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    # routes
    new Laggar.Routers.Servers()
    # init history
    Backbone.history.start
      pushState: true
    
    #bootstrap
    @initBootstrap()
    # nav links
    @initHeaderLinks()
    
  initBootstrap: =>
    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()

  initHeaderLinks: =>
    $('.nav_home_link').click (event) =>
      event.preventDefault()
      Backbone.history.navigate("", true)
      return false

$(document).ready ->
  Laggar.init()
  
