class Server < ActiveRecord::Base
  
  attr_accessible :name
  
  validates :name, :presence => true
  validates :token, :uniqueness => { :case_sensitive => false }
  
  scope :sortable, order(:sort_index, :created_at)
  
  before_create :set_token
  
  private
  
  def set_token
    self.token = SecureRandom.hex(16)
    self.sort_index = Server.count
  end
  
end
