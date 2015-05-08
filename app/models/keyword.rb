class Keyword < ActiveRecord::Base
  default_scope { order('id DESC') }
  belongs_to :group

  attr_accessor :review_url
end
