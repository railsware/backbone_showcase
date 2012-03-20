class ServerPresenter < BasePresenter
  presents :server
  delegate :id, :name, :token, to: :server


  def js_show
    {
      id: id,
      name: name,
      token: token
    }
  end
end
