class Note < ActiveRecord::Base

 has_and_belongs_to_many :pages
 has_and_belongs_to_many :users
 
 has_many :responses
 belongs_to :user

 validates :title,  :presence => true
end
