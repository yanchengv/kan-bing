Mimas::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

  root 'home#index'
  #root 'home#test'
  #root 'home#test2'
  get '/home',    to:'home#home'
  mount Dione::Engine, :at=>'/dione'

  #resources :sessions, only: [:new, :create, :destroy]
  resources :sessions do
    collection do
      #match '/signin',  to: 'sessions#new',         via: 'get'
      match '/signout', to: 'sessions#destroy',     via: 'delete'
    end
  end
  resource :home do
    collection do
      get '/about',   to: 'home#about'
      get '/contact', to: 'home#contact'

    end
  end
  resource :code do
      collection do
        get '/code_image' => 'code#code_image'
      end
  end
  resources :users do
    collection do
      get '/signup',  to: 'users#new'
      get '/setting' => 'users#setting'
      get '/code_refresh' => 'users#code_refresh'
      post '/profile_update'=>'users#profile_update'
      post '/password_update'=>'users#password_update'
    end
  end

  resource :navigations do
    collection do
      post 'signed_mini'
      get '/navigationhealthrecord'  =>'navigations#navigation_health_record'
      get '/navigationconsultation'  =>'navigations#remote_consultation'
    end
  end
  resource :appointments do
    collection do
      post '/create', to:'appointments#create'
      match '/myappointment'    , to: 'appointments#myappointment',:via => [:post,:get]
      get '/get_department', to: 'appointments#get_dept'
      post '/tagabsence'  , to:'appointments#tagabsence'   #标记取消
      post '/tagcancel' , to:'appointments#tagcancel'
      delete '/delUser', to: 'appointments#delUser'
    end
  end

  resources :appointment_schedules do
    collection do
      get '/doctorschedule', to:'appointment_schedules#doctorschedule'
      get '/cancelthisweekschedule', to:'appointment_schedules#cancelthisweekschedule'
    end
  end
  resources :appointment_cancel_schedules do
    collection do
      get '/destroy',to:'appointment_cancel_schedules#destroy'
    end
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
