Mimas::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

  root 'home#index'
  get '/home',    to:'home#home'
  mount Dione::Engine, :at=>'/dione'
  #mount Jsdicom::Engine, :at=>'/dicom'
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
      get '/find_by_name' => 'users#find_by_name'
      post '/find_by_name2' => 'users#find_by_name2'
      post '/find_by_name3' => 'users#find_by_name3'
    end
  end
 resource :doctors do
   collection do
     get '/index_doctors_list',to:'doctors#index_doctors_list'
     get '/get_aspects', to:'doctors#get_aspects'
     get '/doctorpage/:id',to:'doctors#doctor_page'
     get '/doc_aspects' , to: 'doctors#doc_aspects'
     get '/doctorfriends',to: 'doctors#friends'
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
      match '/get_doctors', to: 'appointments#get_doctors'  ,:via => [:post,:get]
    end
  end

  resources :appointment_schedules do
    collection do
      post '/create', to: 'appointment_schedules#create'
      get '/doctorschedule', to:'appointment_schedules#doctorschedule'
      get '/cancelthisweekschedule', to:'appointment_schedules#cancelthisweekschedule'
      get '/myschedule', to: 'appointment_schedules#myschedule'
    end
  end
  resources :appointment_cancel_schedules do
    collection do
      post '/destroy',to:'appointment_cancel_schedules#destroy'
    end
  end
  resource :patients do
    collection do
      get '/get_aspects', to:'patients#get_aspects'
      get '/patientpage/:id',to:'patients#patient_page'
      get '/patientfriends',to: 'patients#friends'
      get '/change_main_doctor', to: 'patients#change_main_doctor'
    end
  end

  resources :photos do
    collection do
      post '/upload',to:'photos#create'
    end
  end
  resources :health_records do
    collection do
      get '/ct',  to: 'health_records#ct'
      get '/ultrasound', to: 'health_records#ultrasound'
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
