Rails.application.routes.draw do
  #admin panel
  namespace :admin do
    devise_scope :user do
      get 'sign_in', to: 'sessions#new'
      post 'sign_in', to: 'sessions#create'
      delete 'sign_out', to: 'sessions#destroy'
      resources :passwords
      get 'cancel' , to: 'registrations#cancel'
      post '/' , to: 'registrations#create'
      get 'sign_up' , to: 'registrations#new'
      get 'edit' , to: 'registrations#edit'
      patch '/' , to: 'registrations#update'
      put '/' , to: 'registrations#update'
      post '/' , to: 'registrations#destroy'
      # resources :confirmations
      # resources :unlocks
    end

    root to: 'home#index', as: 'home'
    get '/:store_id/operating-data',:to=>'home#operating_data',:as=>"operating-data"
      resources :stores do
        resources :coupons
        member do
          get :followers
        end
    end
  end

  #basic relationship settings
  resources :posts
  resources :stores
  resources :comments, only: [:create, :destroy]
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  resources :users do
    resources :coupons
    member do
      get :followers
    end
  end

  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  
  #sign in/sign out authenication page settings 
  authenticated :user do
    root to: 'home#index', as: 'home'
    get '/offical',:to=>'home#offical',:as=>'offical'

  end
  unauthenticated :user do
    root 'home#front'
  end



  #coupon pages settings
  post '/users/:user_id/coupons/:id/distribute', :to => 'coupons#distribute',:as =>"distribute_user_coupon"
  get '/users/:user_id/coupons/:id/redeem', :to => 'coupons#redeem',:as =>"redeem_user_coupon"
  
  

  #information pages settings
  get '/food',:to=>'home#food',:as=>"food"
  get '/play',:to=>'home#play',:as=>"play"
  get '/online',:to=>'home#online',:as=>"online"


  #pusher settings
  post 'pusher/auth'
  match '/posters/:id' => "posts#shownolayout",via: :get#post
  match '/commenters/:id' => "comments#shownolayout",via: :get#post

  #coupon 列表
  get '/users/:user_id/coupons-used',:to=>'coupons#used',:as=>"user_coupons_used"
  get '/users/:user_id/coupons-notuse',:to=>'coupons#notuse',:as=>"user_coupons_notuse"
  get '/users/:user_id/coupons-overdue',:to=>'coupons#overdue',:as=>"user_coupons_overdue"


  #admin landing pages
  get '/admin-landing',:to=> 'pages#admin_landing',:as=>"admin_front"


end
