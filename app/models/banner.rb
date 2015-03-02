class Banner < ActiveRecord::Base

  attr_accessor :users

  belongs_to :client
  has_and_belongs_to_many :swfs

  before_create :add_token

  private
  def add_token
    begin
      self.secure_url = SecureRandom.hex[0,50]
    end while self.class.exists?(secure_url: secure_url)
  end
  
end
