module Tokenable
  extend ActiveSupport::Concern
  
  included do
    before_create :create_token
  end
  
  private
  
  def create_token
    self.token = SecureRandom.urlsafe_base64
  end

end