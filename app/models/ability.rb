class Ability
  include CanCan::Ability

  def initialize(user)    
    user ||= User.new # guest user (not logged in)
      if user.role? :admin
        can :manage, :all
		    can :manage, User, :id => user.id 
		
      elsif user.role? :editor
        can :manage, [Page, Section, Collection, Footer,Navigation, Publication, Post, Post, Testimonial,Asset, Faq, Image, Youtube, Help, Rewrite, Version, Help]
        can [:read, :update], User, :id => user.id
        
        
      elsif user.role? :author
        can [:read, :update, :create], [ Publication, Post ]
        can [:read, :update], User, :id => user.id
        can [:read], Help
  
      else
        can :read, [Page, Publication, Post]
        can :create , Comment
      end
    end
end
