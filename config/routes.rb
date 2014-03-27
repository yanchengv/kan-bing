Mimas::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

  root 'home#index'
  get '/home', to: 'home#home'
  mount Dione::Engine, :at => '/dione'
  mount Jsdicom::Engine, :at => '/dicom'
  resources :sessions do
    collection do
      #match '/signin',  to: 'sessions#new',         via: 'get'
      match '/signout', to: 'sessions#destroy', via: 'delete'
    end
  end
  resource :home do
    collection do
      get '/about', to: 'home#about'
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
      get '/signup', to: 'users#new'
      get '/setting' => 'users#setting'
      get '/code_refresh' => 'users#code_refresh'
      post '/profile_update' => 'users#profile_update'
      post '/password_update' => 'users#password_update'
      get '/find_by_name' => 'users#find_by_name'
      post '/find_by_name3' => 'users#find_by_name3'
    end
  end
  resource :doctors do
    collection do
      get '/get_main_patients', to: 'doctors#get_main_patients'
      get '/get_fri_patients', to: 'doctors#get_fri_patients'
      get '/get_patient_aspects', to: 'doctors#get_patient_aspects'
      get '/index_doctors_list', to: 'doctors#index_doctors_list'
      get '/get_aspects', to: 'doctors#get_aspects'
      match '/doctorpage/:id', to: 'doctors#doctor_page', via: [:get, :delete]
      get '/doc_aspects', to: 'doctors#doc_aspects'
      get '/doctorfriends', to: 'doctors#friends'
      get  '/show_friends',to:'doctors#show_friends'
      get '/doctor_appointment/:id', to: 'doctors#doctor_appointment'
      get '/show_doctor',to:'doctors#index_doctor_page'
      get '/get_patients', to:'doctors#get_patients'


    end
  end
  resource :navigations do
    collection do
      post 'signed_mini'
      get '/navigationhealthrecord' => 'navigations#navigation_health_record'
      get '/navigationconsultation' => 'navigations#remote_consultation'
    end
  end
  resource :appointments do
    collection do
      get 'find_by_id', to: 'appointments#find_by_id'
      post '/create', to: 'appointments#create'
      match '/myappointment', to: 'appointments#myappointment', :via => [:post, :get]
      get '/get_department', to: 'appointments#get_dept'
      post '/tagabsence', to: 'appointments#tagabsence' #标记取消
      post '/tagcancel', to: 'appointments#tagcancel'
      post '/tagcomplete', to: 'appointments#tagcomplete'
      delete '/delUser', to: 'appointments#delUser'
      match '/get_doctors', to: 'appointments#get_doctors', :via => [:post, :get]

    end
  end

  resources :appointment_schedules do
    collection do
      post '/create', to: 'appointment_schedules#create'
      get '/doctorschedule', to: 'appointment_schedules#doctorschedule'
      get '/doctorschedule2', to: 'appointment_schedules#doctorschedule2'
      get '/doc_schedule', to:'appointment_schedules#doc_schedule'
      #get '/cancelthisweekschedule', to: 'appointment_schedules#cancelthisweekschedule'
      post '/updateschedule', to: 'appointment_schedules#updateschedule'
      get '/myschedule', to: 'appointment_schedules#myschedule'
      get '/show_appschedules/:id',to:'appointment_schedules#show_appschedules'
    end
  end
  #resources :appointment_cancel_schedules do
  #  collection do
  #    post '/destroy', to: 'appointment_cancel_schedules#destroy'
  #  end
  #end
  resource :patients do
    collection do
      get '/get_aspects', to: 'patients#get_aspects'
      match '/patientpage/:id', to: 'patients#patient_page', via: [:get, :delete]
      get '/patientfriends', to: 'patients#friends'
      get '/change_main_doctor', to: 'patients#change_main_doctor'
      get '/public_verification', to:'patients#public_verification'
      get '/my_doctors',to:'patients#show_doctors'
    end
  end

  resources :photos do
    collection do
      post '/upload', to: 'photos#create'
    end
  end
  resources :health_records do
    collection do
      get '/ct', to: 'health_records#ct'
      get '/ultrasound', to: 'health_records#ultrasound'
      get '/get_video', to: 'health_records#get_video'
      get '/go_where', to: 'health_records#go_where'
      get '/inspection_report', to: 'health_records#inspection_report'
      post '/ct2',to: 'health_records#ct2'
      post '/ultrasound2',to: 'health_records#ultrasound2'
      post '/inspection_report2',to: 'health_records#inspection_report2'
      post '/blood_pressure',to:'health_records#blood_pressure'
      post '/dicom',to:'health_records#dicom'
      post '/get_data',to: 'health_records#get_data'
    end
  end

  get "/consultations/:id/edit" => 'consultations#edit'
  resources :consultations do
    collection do
      match ':action/:id',:via => [:post,:get]
    end
  end
  resources :channels do
    resources :messages
  end
  resources :cons_orders do
    collection do
      match ':action/:id',:via => [:post,:get]
    end
  end
  #resources :consultation_create_records
  #match '/consultations/neworder' => 'consultations#neworder',,:via => [:post,:get]

  resources :reports, only: [:edit, :show, :update]
  resource :notifications do
    collection do
      post '/add_fri_doc', to: 'notifications#add_fri_doc'
      post '/add_con_doc', to: 'notifications#add_con_doc'
      post '/add_main_doc', to: 'notifications#add_main_doc'
      get 'get_all_notice', to: 'notifications#get_all_notice'
      post 'agree_request', to: 'notifications#agree_request'
      delete 'reject_or_delete_notice', to: 'notifications#reject_or_delete_notice'
      delete 'del_con_doc', to: 'notifications#del_con_doc'
      delete 'del_con_pat', to: 'notifications#del_con_pat'
      get '/show_all_notice', to: 'notifications#show_all_notice'
      get 'get_app_notice', to: 'notifications#get_app_notice'
      post '/delUser', to: 'notifications#delUser'

      get '/show_doctor_notices',to:'notifications#show_doctor_notices'
      get '/show_patient_notices',to:'notifications#show_patient_notices'

      get 'get_app_notices', to:'notifications#get_app_notices'
      get 'get_con_notices', to:'notifications#get_con_notices'
    end
  end

  resource :mimas_data_sync_queue do
    collection do
      post '/create', to: 'mimas_data_sync_queue#create'
      post '/destroy', to: 'mimas_data_sync_queue#destroy'
      post '/change', to: 'mimas_data_sync_queue#change'
      get '/show', to:'mimas_data_sync_queue#show'
      get '/destroy_by_id', to:'mimas_data_sync_queue#destroy_by_id'
      post '/find_by_id',to:'mimas_data_sync_queue#find_by_id'
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
