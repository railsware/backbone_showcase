class Api::BaseController < ApplicationController
  abstract!
  
  private
  
  def response_success_api(data)
    respond_to do |format|
      format.xml  { render :xml => data.to_xml(:root => "response", :dasherize => false, :skip_types => true) }
      format.json { render :json => data, :callback => params[:callback] }
    end
  end
  
  def response_error_api(data)
    respond_to do |format|
      format.xml  { render :xml => data, :status => :unprocessable_entity }
      format.json { render :json => data, :status => :unprocessable_entity }
    end
  end
  
end
