class Laggar.Routers.Servers extends Backbone.Router
  routes:
    ""                  : "index"
    "server/:id"        : "show"
    "*path"             : "index"
  
  initialize: (options) =>
    @servers = new Laggar.Collections.Servers()
    @servers.reset($("#mainContainer").data('servers'))
  
  index: =>
    view = new Laggar.Views.ServersIndex(collection: @servers)
    $("#mainContainer").empty().html(view.render().el)
    
  show: (id) =>
    server = @servers.get(id)
    return (Backbone.history.navigate("", true)) unless server
    
    $("#mainContainer").empty().html("Server name: #{server.get('name')}")
    console.info id
