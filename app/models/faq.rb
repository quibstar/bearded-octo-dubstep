class Faq < ActiveRecord::Base

	has_and_belongs_to_many :sections
	
	validates_presence_of :question
	validates_presence_of :answer
  
  	# attr_accessible :question, :answer
end
