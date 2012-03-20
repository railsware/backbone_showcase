class Laggar.Views.ServersIndex extends Backbone.View
  template: JST['servers/index']
  events:
    'click .open_new_server'        : 'openNewServer'
    'click .close_new_server'       : 'closeNewServer'
    'submit #addServerForm'         : 'addServer'

  initialize: ->
    @collection.on 'add', @renderOne
    @collection.on 'reset', @renderAll
  
  render: =>
    $(@el).html(@template())
    @renderAll()
    this
  
  renderOne: (server) =>
    view = new Laggar.Views.ServerLi({model: server})
    @$('#serverList').append(view.render().el)
  
  renderAll: =>
    @collection.each @renderOne
    
  openNewServer: (event) =>
    event.preventDefault()
    @$('#addNewServer').addClass('adding')
    @$('#addServerForm div.control-group').removeClass('error')
    return false

  closeNewServer: (event) =>
    event.preventDefault()
    $('#addNewServer').removeClass('adding')
    return false
    
  addServer: (event) =>
    event.preventDefault()
    attributes = 
      name: @$('#serverName').val()
    @collection.create attributes,
      wait: true
      beforeSend: =>
        @$('#addServerForm div.control-group').removeClass('error')
      success: =>
        @$('#addServerForm')[0].reset()
        @$('#addNewServer').removeClass('adding')
      error: @handleErrors
        
  handleErrors: (server, response) =>
    if 422 == response.status
      errors = $.parseJSON(response.responseText)
      for attribute, messages of errors
        @$("#server#{attribute.charAt(0).toUpperCase()}#{attribute.slice(1)}").parents('div.control-group').addClass('error')