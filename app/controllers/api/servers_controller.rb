class Api::ServersController < Api::BaseController
  respond_to :json
  
  def index
    @servers = Server.sortable
    response_success_api(@servers.map{|s| present(s).js_show })
  end
  
  def create
    @server = Server.create(params[:server])
    if @server.save
      response_success_api(present(@server).js_show)
    else
      response_error_api(@server.errors)
    end
  end
  
  def update
    @server = Server.find(params[:id])
    if @server.update_attributes(params[:server])
      response_success_api(present(@server).js_show)
    else
      response_error_api(@server.errors)
    end
  end
  
  def destroy
    @server = Server.find(params[:id])
    if @server.destroy
      response_success_api(present(@server).js_show)
    else
      response_error_api(@server.errors)
    end
  end
  
end
