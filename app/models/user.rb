class User < ActiveRecord::Base
	
	has_paper_trail :on => [:update, :destroy],:skip => [:image, :encrypted_password, :reset_password_token, :reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip,:last_sign_in_ip,:created_at,:updated_at,:invitation_token,:invitation_sent_at,:invitation_accepted_at, :invitation_limit, :invitation_sent_at, :invitation_token, :invited_by_id, :invited_by_type]
	
	has_and_belongs_to_many :roles
	has_and_belongs_to_many :notes
	
	has_many :posts
	
	# join models and association for categories
	has_many :asset_categories, :as => :categorizable, :dependent => :destroy
	has_many :categories, :through => :asset_categories
	
	
	devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :invite_for => 2.weeks
	
	
	# attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name, :last_name, :title, :phone, :twitter, :facebook, :linkedin, :role_ids, :image,:bio, :image_cache, :remove_image,:category_ids, :invitation_accepted_at, :invitation_limit, :invitation_sent_at, :invitation_token, :invited_by_id, :invited_by_type
	
	def name
		[first_name, last_name].compact.join(' ')
	end
	
	def full_name
		"#{self.first_name} #{self.last_name}"
	end
	
	def role?(role)
	    return !!self.roles.find_by_name(role.to_s)
	end
	
	mount_uploader :image, UserUploader

end
