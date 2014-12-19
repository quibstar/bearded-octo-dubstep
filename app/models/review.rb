class Review < ActiveRecord::Base

  before_create :add_token

  private
  def add_token
    begin
      self.url = SecureRandom.hex[0,50]
    end while self.class.exists?(url: url)
  end
end
