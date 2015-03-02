Adwordsassistant::Application.routes.draw do

  get "document_featured_image/:id" => 'admin/documents#featured_image', :as => 'document_image'

  get "audio_featured_image/:id" => 'admin/audios#featured_image', :as => 'audio_image'
  
  get "video_featured_image/:id" => 'admin/videos#featured_image', :as => 'video_image'
  
  get "article_featured_image/:id" => "admin/articles#featured_image",  :as => "article_image"
  
  get "post_featured_image/:id" => "admin/posts#featured_image",  :as => "post_image"
  
  get "section_cpmv/:id" => "admin/sections#section_cpmv", :as => "section_cpmv"

  get "publication/:publication_id/post/:post_id/comment/:id" => 'admin/comments#status', :as => "comment/status"
  

resources :reviews, :only => :show
resources :topics do
  resources :groups do 
    resources :copies 
  end
end

resources :banners, :only => :show

resources :copies
    
devise_for :users, :controllers => { :registrations => "admin/registrations" }

 namespace :admin do

    resources :clients
    resources :reviews
    
    resources :banners
    resources :gifs
    resources :swfs

    resources :users do 
      post :generate_new_password_email
    end

    resources :topics do
      resources :groups do 
        resources :copies 
      end
      collection {post :import}
      collection {post :keywords}
    end

    resources :groups
    resources :copies
    
    resources :dashboard, :only => :index
    
    resources :navigations

    resources :css, :only => [:index, :update]
    
    resources :faqs
    
    resources :testimonials 
    
    resources :categories 
    
    resources :assets

    resources :helps
    
    resources :images 

    resources :audios

    resources :documents

    resources :links
    
    resources :footers
    
    resources :forms do 
      resources :fields
    end

    resources :fieldOptions, controller: 'field_options'
    
    resources :sliders do
      resources :slides
    end

    resources :slides
    
    resources :comments
    
    resources :youtubes
    
    resources :settings

    resources :collections

    resources :versions, :only => [:index, :show]
    
    resources :rewrites

    resources :notes
    resources :responses
    
    resources :pages do
        post :sort, on: :collection
        resources :sections do
          post :sort, on: :collection
          resources :contents
        end
      end
      
    resources :footers do
      resources :sections do
        resources :contents
      end
    end

    resources :multi_navigations do
        resources :sections do
          resources :contents
        end
    end
      
    resources :shared_contents do
        resources :sections do
          resources :contents
        end
    end

    resources :publications do 
      resources :posts do 
        resources :comments   
      end
        resources :sections do
          resources :contents
        end
    end
    resources :sections
    # resources :fieldOptions

  end

  get 'restore' => 'admin/versions#undo_destroy', :as => 'undo'

  resources :comments, only: [:new, :create, :show]


  get 'search' => 'search#index', :as => 'search'

  get "submit" => "site#submit_form", :as => "submit"

  get "publication/:publication_id/:id" => "posts#show", :as => "post/show"

  get "publication/:publication_id/category/:id" => "posts#category", :as => "post/category"

  get  '*url_path' => 'site#show'
  
  root :to => 'site#show'
end
