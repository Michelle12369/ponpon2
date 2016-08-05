Rails.application.routes.draw do
  #basic relationship settings

  resources :posts
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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
