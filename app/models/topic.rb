class Topic < ActiveRecord::Base
  extend FriendlyId
    friendly_id :name, use: :slugged

  default_scope { order('id DESC') }

  has_many :groups, :dependent => :destroy
end
