class Laggar.Views.ServerLi extends Backbone.View
  tagName: "li"
  className: "list"
  template: JST['servers/li']
  events:
    'click .edit_server_btn'            : 'openEditForm'
    'submit .edit_server_form'          : 'updateObject'
    'click .cancel_edit_server_btn'     : 'closeEditForm'
    'click .delete_server_btn'          : 'openDeleteForm'
    'click .confirm_delete_server_btn'  : 'deleteObject'
    'click .cancel_delete_server_btn'   : 'closeDeleteForm'
    'click .main p'                     : 'showServer'
  
  initialize: =>
    @model.on 'change', @render
    @model.on 'destroy', @remove

  render: =>
    $(@el).html(@template(server: @model))
    this
    
  remove: =>
    $(@el).remove()
    
  updateObject: (event) =>
    event.preventDefault()
    attributes = 
      name: @$('.server_name').val()
    @model.save attributes, 
      wait: true
      success: =>
        @$('.server_list').removeClass('editing')
      error: @handleErrors
    return false
    
  deleteObject: (event) =>
    event.preventDefault()
    @model.destroy 
      wait: true
      success: =>
        @$('.server_list').removeClass('deleting')
      error: @handleErrors
    return false
    
  showServer: =>
    Backbone.history.navigate("server/#{@model.get('id')}", true)
    
  openEditForm: (event) =>
    event.preventDefault()
    @$('.server_list').addClass('editing')
    return false
  
  closeEditForm: (event) =>
    event.preventDefault()
    @$('.server_list').removeClass('editing')
    return false
    
  openDeleteForm: (event) =>
    event.preventDefault()
    @$('.server_list').addClass('deleting')
    return false
    
  closeDeleteForm: (event) =>
    event.preventDefault()
    @$('.server_list').removeClass('deleting')
    return false
    
  handleErrors: (server, response) =>
    response