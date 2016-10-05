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
    post '/stores/:store_id/coupons/:id/distribute/send',:to=>'coupons#admin_send',:as=>"send"
    get '/stores/:store_id/coupons/:id/confirm',:to=>'coupons#admin_confirm',:as=>"confirm"
    # post '/stores/:store_id/coupons/:id/redeem',:to=>'coupons#admin_redeem',:as=>"redeem"
    # get '/stores/:store_id/coupons/:id/qrcode',:to=>'coupons#admin_qrcode',:as=>"qrcode"

    resources :posts,except: :new do
        collection do
        get 'analysis'
      end
    end
    resources :comments, only: [:create, :destroy]
    match :like, to: 'likes#create', as: :like, via: :post
    match :unlike, to: 'likes#destroy', as: :unlike, via: :post
    
    resources :stores do  
      resources :items,except: :new
      resources :coupons,:except => [:edit,:destroy] do
        resources :searches,only:[:new,:create,:show]
      end
      member do
        get :followers

      end
    end
  end





  #basic relationship settings
  resources :posts,except: [:index,:new]
  resources :stores,:except => [:edit,:destroy]

  # resources :items
  resources :comments, only: [:create, :destroy]
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks",:registrations => 'registrations' }
  
  resources :users do
    resources :coupons,:except => [:edit,:destroy]
    member do
      get :followers
      get :friends
      get :stores
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
  get '/stores/:store_id/coupons/:id/take',:to=>'coupons#take',:as=>"take"
  get '/users/:user_id/coupons/:id/download',:to=>'coupons#download',:as=>"download"

  #information pages settings
  get '/food',:to=>'home#food',:as=>"food"
  get '/play',:to=>'home#play',:as=>"play"
  get '/online',:to=>'home#online',:as=>"online"
  get '/search',:to=>'home#search_user',:as=>"search_user"

  get '/recommend',:to=>'home#recommend',:as=>"recommend"

  #pusher settings
  # post 'pusher/auth'
  # match '/posters/:id' => "posts#shownolayout",via: :get#post
  # match '/commenters/:id' => "comments#shownolayout",via: :get#post

  #coupon 列表
  get '/users/:user_id/coupons-used',:to=>'coupons#used',:as=>"user_coupons_used"
  get '/users/:user_id/coupons-notuse',:to=>'coupons#notuse',:as=>"user_coupons_notuse"
  get '/users/:user_id/coupons-overdue',:to=>'coupons#overdue',:as=>"user_coupons_overdue"

  #admin landing pages
  get '/admin-landing',:to=> 'pages#admin_landing',:as=>"admin_front"
  get '/contract',:to=> 'pages#contract',:as=>"contract"
  get '/complete',:to=> 'pages#complete_apply',:as=>"complete_apply"
  get '/contract-content',:to=>'pages#contract_content',:as=>"contract_content"

  #static page
  get '/faq',:to=>'pages#faq',:as=>"faq"

end
