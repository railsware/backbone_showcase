class ServersController < ApplicationController
  
  def index
    @servers = Server.sortable
  end
  
end
