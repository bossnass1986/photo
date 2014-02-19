Grokphoto::Application.routes.draw do

  root :to => 'home#index'
  match 'timestamp' => 'home#timestamp' # used to keep passenger spooled up in prod
  match 'sitemap' => 'home#sitemap'
  match 'blog' => 'home#blog'

  resources :private_galleries, :only => :show
  resources :galleries, :only => :show
  resources :pages, :only => :show
  resources :posts, :only => [:index, :show], :to => 'posts#index'
  resources :contact_requests, :only => [:new, :create] do
    get :thanks, :on => :collection
  end

  devise_for :photographers

  match 'admin' => 'admin/pages#index'
  namespace :admin do
    resources :pages
      get '/', :to => 'pages#index'
    resources :events, :only => :index
    resource :photographer, :only => [:edit, :update]

    resources :posts
    resources :galleries
    resources :private_galleries do
      get :invite, :on => :member
      put :send_invite, :on => :member
    end
    resources :photos, :only => [:edit, :update, :destroy] do
      put 'sort', :on => :collection
    end
  end

end
