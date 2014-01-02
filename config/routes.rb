Mimas::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

  root 'home#index'
  mount Dione::Engine, :at=>'/dione'

  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/about',   to: 'home#about', :via => [:get, :post]
  match '/contact', to: 'home#contact', :via => [:get, :post]
  get '/code/code_image' => 'code#code_image'
  get '/setting' => 'users#setting'
  get '/code_refresh' => 'users#code_refresh'
  post '/user/profile_update'=>'users#profile_update'
  post '/user/password_update'=>'users#password_update'
  resource :navigations do
    member do
      post 'signed_mini'
    end
  end
  get '/navigationhealthrecord'  =>'navigations#navigation_health_record'
  get '/navigationappointment'  =>'navigations#navigation_appointment'
  get '/navigationconsultation'  =>'navigations#remote_consultation'
  get '/index' => 'home#index'
  get 'myappointment'    , to: 'appointments#myappointment'
  resource :doctors do
    member do
      get :home
    end
  end
  get '/doctors/home' , to:'doctors#home'
  resource :home do
  end
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
