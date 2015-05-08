class Review < ActiveRecord::Base

  before_create :add_token

  has_and_belongs_to_many :topics

  private
  def add_token
    begin
      self.url = SecureRandom.hex[0,50]
    end while self.class.exists?(url: url)
  end
end
