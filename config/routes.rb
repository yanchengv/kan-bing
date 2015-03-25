Mimas::Application.routes.draw do

  resources :skills
  namespace  :admin do
      get '/skill'   ,to: 'skills#index'
  end
  #get "hospital/:name" ,to: 'hospitals#show'
  get "hospital/:id" ,to: 'hospitals#show'

  get "inspection_report/create"
  resources :shares
  resources :groups   do
    member  do
      post :join
      delete :quit
    end
    resources :items   , only: [:new, :create,:show,:index,:edit]
  end


  #resources :posts do
  #  resources :comments, only: [:index, :new, :create]
  #end
  #resources :comments, only: [:show, :edit, :update, :destroy]

  resources :items ,except:[:create]  do
    member  do
      post :join
      delete :quit
    end
  end

  resources :notes do
    collection do
      post 'batch_delete', to: 'notes#batch_del'
      post 'batch_update_type', to: 'notes#batch_update_type'
      post 'is_top', to:'notes#is_top'
      get 'search_index', to:'notes#search_index'
      get 'patient_search', to: 'notes#patient_search'
      post 'upload' => 'notes#upload'
    end
    member  do
      post 'share', to: 'notes#share_to_my_patients'
      delete 'delShare', to: 'notes#del_share'
    end
  end
  resources :note_admireds do
    collection do
      post 'del_admired', to: 'note_admireds#del_admired'
    end
  end
  resources :note_comments
  resources :note_forwardings
  resources :note_types do
    collection do
      post 'async_create', to: 'note_types#async_create'
    end
  end
  resources :note_tags
  resources :consult_questions
  resources :consult_results
  resources :consult_accuses


  mount WeixinRailsMiddleware::Engine, at: "/"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

  root 'home#index'
  get '/home', to: 'home#home'
  get "/more", to: 'home#more'
  get "/m_list", to: 'home#m_list'
  get "/wbxr", to: 'home#more'
  get "/csjr", to: 'home#csjr'
  get "/zlrl", to: 'home#zlrl'
  get "/hos", to: 'home#hos'
  get "/hos_c", to: 'home#hos_c'

  mount Dione::Engine, :at => '/dione'
  mount Jsdicom::Engine, :at => '/dicom'
  resource :phone do
    collection do
      get 'mobile_retrieve_page',to:'phone#mobile_retrieve_page'
      post 'send_message',to:'phone#send_message'
      get 'check_verify_code',to:'phone#check_verify_code'
      get 'check_phone',to:'phone#check_phone'
      post 'update_pwd_page',to:'phone#update_pwd_page'
      post 'reset_pwd', to:'phone#reset_pwd'
    end
  end
  namespace :mobile_app do
    resources :leave_messages do
      collection do
        post 'create', to: 'leave_messages#create'
        get 'index', to: 'leave_messages#index'
        get 'show_messages', to:'leave_messages#show_messages'
        get 'find_messages_by_user_id', to:'leave_messages#find_messages_by_user_id'
        get 'find_replies_by_user_id', to:'leave_messages#find_replies_by_user_id'
        get 'show_message_replies', to:'leave_messages#show_message_replies'
        post 'create_like' , to: 'leave_messages#create_like'
        post 'create_reply', to: 'leave_messages#create_reply'
        get 'find_user_message_info', to:'leave_messages#find_user_message_info'
        post 'upload_image', to:'leave_messages#upload_image'
      end
    end


   #  发送短信激活验证码
   resources :sms_center do
           collection do
             post 'sent',to:'sms_center#sent'
           end
   end
  end
  resource :pregnancy_knowledges do
    collection do
      get 'app_show',to:'pregnancy_knowledges#index'
      get 'show_parent',to:'pregnancy_knowledges#show_parent'
      get 'show_child',to:'pregnancy_knowledges#show_child'
      get 'pregnancy_app',to:'pregnancy_knowledges#pregnancy_app'
    end
  end
  resources :home_menu do
    collection do
      get '/show/:id', to:'home_menu#show'
    end
  end
  resources :home_pages
  get 'center/:link_url', to: 'home_pages#show_content'
  resources :sessions do
    collection do
      #match '/signin',  to: 'sessions#new',         via: 'get'
      match '/signout', to: 'sessions#destroy', via: [:delete,:get]
      post '/login_public',to: 'sessions#login_interface'    #gremed接口
      #match 'checksignedin_app', to: 'sessions#check_signed_in_app', via: [:get, :post]#移动端接口,检查是否当前登录用户
      #post '/app_login',to: 'sessions#login_app'    #移动端接口,登录
      #post 'app_sign_up', to:'sessions#sign_up_app' #移动端接口,注册
      post '/change_login_user', to:'sessions#change_login_user'   #更改登录用户身份

      get 'register_page',to:'sessions#register_page'
      post 'sign_up',to:'sessions#sign_up'
      get 'check_email', to:'sessions#check_email'
      get 'check_username', to:'sessions#check_username'

      get 'check_phone', to:'sessions#check_phone'
      get 'check_code', to:'sessions#check_code'
      get 'activated_user',to:'sessions#activated_user'
      post 'activated',to:'sessions#activated'

      post 'init_user' ,to:'sessions#init_user'
      post 'init_user2' ,to:'sessions#init_user2'

      get 'activated_use_email',to:'sessions#email_activated'

      get 'find_pwd_type', to:'sessions#find_pwd_type'

      post 'login_center',to:'sessions#login_center'
       post 'create',to:'sessions#create'
    end
  end
  resources :app_sessions do
    collection do
      post '/app_login',to: 'app_sessions#login_app'    #移动端接口,登录
      match 'app_checksignedin', to: 'app_sessions#check_signed_in_app', via: [:get, :post]  #移动端接口,检查是否当前登录用户
      post 'app_sign_up', to:'app_sessions#sign_up_app'  #移动端接口,注册
      post 'app_send_email', to:'app_sessions#send_email_app'
      post 'app_reset_password', to:'app_sessions#reset_password_app'
      get 'app_find_by_md5id', to:'app_sessions#find_by_md5id_app'
    end
  end

  resource :app_admin_replies do
    collection do
      post 'app_create_reply', to: 'app_admin_replies#create_reply_app'
    end
  end

  resource :app_user_feedbacks do
    collection do
      get 'app_show_all', to: 'app_user_feedbacks#show_all_app'
      post 'app_create_feedback', to: 'app_user_feedbacks#create_feedback_app'
      get 'app_get_feedback', to: 'app_user_feedbacks#get_feedback_app'
    end
  end

  resource :versions do
    collection do
      get 'app_show_version', to:'apk_versions#show_version_app'
      post 'app_save_version', to:'apk_versions#save_version_app'
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
      get  '/username_verification',to:'users#username_verification'
      get '/check_username',to:'users#check_username'
      get '/check_email' ,to:'users#check_email'
      get '/check_phone',to:'users#check_phone'
      get '/check_old_pwd', to:'users#check_old_pwd'
      get '/check_code', to:'users#check_code'
      post 'register_user',to:'users#register_user'


      post 'register_user_hospital',to:'users#register_user_from_hospital'
      #post 'sign_up', to:'users#sign_up'
      #get 'app_get_user', to:'users#get_user_app'
      #post 'app_profile_update', to: 'users#profile_update_app'
      #post 'app_password_update', to:'users#password_update_app'
    end
  end

  resource :app_users do
    collection do
      get 'app_get_user', to:'app_users#get_user_app'  #移动端接口,获取个人信息
      post 'app_profile_update', to: 'app_users#profile_update_app' #移动端接口,修改个人信息
      post 'app_password_update', to:'app_users#password_update_app'  #移动端接口,修改密码
    end
  end

  resources :mailers do
    collection do
      get '/to_retrieve_pwd_page', to:'mailers#to_retrieve_pwd_page'
      post '/pwd_email', to:'mailers#find_password'
      get '/go_to_show_message', to: 'mailers#go_to_show_message'
      get '/update_pwd_page/:md5id', to:'mailers#update_pwd_page'
      post '/reset_pwd', to:'mailers#reset_pwd'
      get '/code_refresh', to:'mailers#code_refresh'

      post 'account_active',to:'mailers#account_active_for_user'
    end
  end

  resource :doctors do
    collection do
      #get '/get_main_patients', to: 'doctors#get_main_patients'
      #get '/get_fri_patients', to: 'doctors#get_fri_patients'
      #get '/get_patient_aspects', to: 'doctors#get_patient_aspects'
      get '/index_doctors_list', to: 'doctors#index_doctors_list'
      #get '/get_aspects', to: 'doctors#get_aspects'
      match '/doctorpage/:id', to: 'doctors#doctor_page', via: [:get, :delete, :doctor_page]
      #get '/doc_aspects', to: 'doctors#doc_aspects'
      #get '/doctorfriends', to: 'doctors#friends'
      get  '/show_friends',to:'doctors#show_friends'
      #get '/doctor_appointment/:id', to: 'doctors#doctor_appointment'
      get '/show_doctor', to: 'doctors#index_doctor'
      get '/doctor_index', to: 'doctors#index_doctor_page'
      get '/get_patients', to:'doctors#get_patients'
      get  '/play_video',to:'doctors#play_video'
      get '/more_video', to:'doctors#more_video'

      get 'app_show_hospital', to:'doctors#get_all_hospital'
      get 'app_show_schedule_doctors', to:'doctors#show_schedule_doctors'
      get 'app_show_doctor_arranges', to:'doctors#show_doctor_arranges'
      get 'app_get_doctor', to:'doctors#get_doc_by_id'
      get 'get_doctor_to_page', to: 'doctors#get_doctor_to_page'
      post 'update_profile',to:'doctors#update_profile'
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
      get '/get_city', to: 'appointments#get_city'
      get '/get_hospital', to: 'appointments#get_hospital'
      get '/get_department', to: 'appointments#get_dept'
      post '/tagabsence', to: 'appointments#tagabsence' #标记取消
      post '/tagcancel', to: 'appointments#tagcancel'
      post '/tagcomplete', to: 'appointments#tagcomplete'
      delete '/delUser', to: 'appointments#delUser'
      match '/get_doctors', to: 'appointments#get_doctors', :via => [:post, :get]
      get '/sync_update', to:'appointments#sync_update'

      post '/app_new_appointment',to:'appointments#new_appointment'
      get 'app_show_myappointment', to:'appointments#show_myappointment'
    end
  end

  resources :appointment_schedules do
    collection do
      match '/create', to: 'appointment_schedules#create',:via => [:get,:post]
      get '/destroy/:id' , to: 'appointment_schedules#destroy'
      get '/doctorschedule', to: 'appointment_schedules#doctorschedule'
      get '/doctorschedule2', to: 'appointment_schedules#doctorschedule2'
      get '/doc_schedule', to:'appointment_schedules#doc_schedule'
      #get '/cancelthisweekschedule', to: 'appointment_schedules#cancelthisweekschedule'
      match '/updateschedule', to: 'appointment_schedules#updateschedule',:via => [:get,:post]
      get '/myschedule', to: 'appointment_schedules#myschedule'
      get '/show_appschedules/:id',to:'appointment_schedules#show_appschedules'
      get '/schedule_template', to: 'appointment_schedules#schedule_template'
    end
  end

  resource :schedule_templates do
    collection do
      get 'show_template', to:'schedule_templates#show_template'
      post '/create_template', to: 'schedule_templates#create'
      get 'show_schedule_template/:id', to:'schedule_templates#get_schedule_template'
      post 'update_template', to: 'schedule_templates#update_template'
      delete 'destroy_template', to: 'schedule_templates#destroy_template'
    end
  end
  #resources :appointment_cancel_schedules do
  #  collection do
  #    post '/destroy', to: 'appointment_cancel_schedules#destroy'
  #  end
  #end
  resource :patients do
    collection do
      #get '/get_aspects', to: 'patients#get_aspects'
      match '/patientpage/:id', to: 'patients#patient_page', via: [:get, :delete]
      #get '/patientfriends', to: 'patients#friends'
      #get '/change_main_doctor', to: 'patients#change_main_doctor'
      get '/public_verification', to:'patients#public_verification'
      get '/my_doctors',to:'patients#show_doctors'
      post 'update_profile',to:'doctors#update_profile'

      get '/my_con_doctors', to: 'patients#my_doctors'

      post 'v1/verification', to:'patients#verification'
      post 'v1/create', to: 'patients#create'
      post 'v1/update', to: 'patients#update'
    end
  end

  resources :photos do
    collection do
      post '/upload', to: 'photos#create'
    end
  end
  resources :health_records do
    collection do
      get '/play_video', to: 'health_records#play_video'
      get '/ct', to: 'health_records#ct'
      get '/get_video', to: 'health_records#get_video'
      get 'go_where', to: 'health_records#go_where'
      get '/inspection_report', to: 'health_records#inspection_report'
      get 'mri',to:'health_records#mri'
      get '/ultrasound', to: 'health_records#ultrasound'

      post '/ct2',to: 'health_records#ct2'
      post '/mri2',to: 'health_records#mri2'
      post '/ultrasound2',to: 'health_records#ultrasound2'
      post '/inspection_report2',to: 'health_records#inspection_report2'
      post '/dicom',to:'health_records#dicom'
      post '/get_data',to: 'health_records#get_data'
      post '/inspection', to: 'health_records#inspection'
      post '/undefined_other', to: 'health_records#undefined_other'
      post '/upload',to:'health_records#upload'
      post '/create_healths', to:'health_records#create_health_data'
    end
  end
  resources :inspection_report do    #健康档案超声同步　v1版本接口
    collection do
      post 'v1/sync_ultrasound', to:'inspection_report#sync_ultrasound_save'
      post 'v1/sync_ultrasound_update', to:'inspection_report#sync_ultrasound_update'
      post 'v1/sync_ultrasound_destroy', to:'inspection_report#sync_ultrasound_destroy'
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
      get '/get_doc_notices', to: 'notifications#get_doc_notices'
      get '/get_pat_notices', to: 'notifications#get_pat_notices'
      get '/pat_app_notices_all', to: 'notifications#pat_app_notices_all'
      get '/doc_fri_notices_all', to: 'notifications#doc_fri_notices_all'
      get '/doc_app_notices_all', to: 'notifications#doc_app_notices_all'
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

      get 'pat_con_notices_all', to:'notifications#con_notices_all'
      get 'doc_con_notices_all', to:'notifications#con_notices_all'
      get 'notes_share_notices_all', to: 'notifications#notes_share_notices'
      get 'show_and_delete_notice', to:'notifications#show_and_delete_notice'

      post 'create', to:'notifications#create'
      post 'app_show_notice',to:'notifications#show_notice_app'
    end
  end

  resource :mimas_data_sync_queue do
    collection do
      post '/create', to: 'mimas_data_sync_queue#create'
      post '/destroy', to: 'mimas_data_sync_queue#destroy'
      post '/change', to: 'mimas_data_sync_queue#change'
      get '/show', to:'mimas_data_sync_queue#show'      #同步接口
      get '/destroy_by_id', to:'mimas_data_sync_queue#destroy_by_id'     #同步接口
      post '/find_by_id',to:'mimas_data_sync_queue#find_by_id'     #同步接口
      post 'create_user',to:'mimas_data_sync_queue#create_user'
      post 'sync_result_create',to:'mimas_data_sync_queue#sync_result_create'
    end
  end

  resource :blood_glucose do
    collection do
      post '/create',to:'blood_glucose#create'
      post 'show',to:'blood_glucose#show'
      get 'all_glucose_data',to:'blood_glucose#all_glucose_data'
      post 'update',to:'blood_glucose#update'

    end
  end

  resource :blood_pressure do
    collection do
      post 'create',to:'blood_pressure#create'
      post 'update',to:'blood_pressure#update'
      post 'show',to:'blood_pressure#show'
      get 'all_blood_pressure',to:'blood_pressure#all_blood_pressure'


    end

  end

  resource :blood_oxygen do
    collection do
      post 'show',to:'blood_oxygen#show'
      post 'create',to:'blood_oxygen#create'
      get 'all_oxygen',to:'blood_oxygen#all_oxygen'
      post 'update',to:'blood_oxygen#update'


    end
  end

  resource :blood_fat do
    collection do
      post 'show',to:'blood_fat#show'
      post 'create',to:'blood_fat#create'
      post 'update',to:'blood_fat#update'
      get'all_blood_fat',to:'blood_fat#all_blood_fat'
    end
  end

  resource :weight do
    collection do
      post 'create',to:'weight#create'
      post 'update',to:'weight#update'
      post 'show',to:'weight#show'
      get 'all_weight_data',to:'weight#all_weight_data'
    end
  end

  # 健康档案页面 脂肪率等
  namespace :highcharts do

    # 身体质量指数
    resource :bmi do
      collection do
        post 'show',to:'bmi#show'
        post 'create',to:'bmi#create'
        post 'update',to:'bmi#update'
        get 'all_bmi_data',to:'bmi#all_bmi_data'
      end
    end
  # 脂肪率
  resource :bfr do
    collection do
      post 'show',to:'bfr#show'
      post 'create',to:'bfr#create'
      post 'update',to:'bfr#update'
      get 'all_bfr_data',to:'bfr#all_bfr_data'
    end
  end

    # 肌肉率
    resource :smrwb do
      collection do
        post 'show',to:'smrwb#show'
        post 'create',to:'smrwb#create'
        post 'update',to:'smrwb#update'
        get 'all_smrwb_data',to:'smrwb#all_smrwb_data'
      end
    end
    # 内脏脂肪指数
    resource :vfl do
      collection do
        post 'show',to:'vfl#show'
        post 'create',to:'vfl#create'
        post 'update',to:'vfl#update'
        get 'all_vfl_data',to:'vfl#all_vfl_data'
      end
    end

    # 身体年龄
    resource :body_age do
      collection do
        post 'show',to:'body_age#show'
        post 'create',to:'body_age#create'
        post 'update',to:'body_age#update'
        get 'all_body_age_data',to:'body_age#all_body_age_data'
      end
    end
    # 基础代谢
    resource :bme do
      collection do
        post 'show',to:'bme#show'
        post 'create',to:'bme#create'
        post 'update',to:'bme#update'
        get 'all_bme_data',to:'bme#all_bme_data'
      end
    end




  end

  # 心电图
  resource :ecg do
    collection do
      get 'show2',to:'ecg#show2'
      post 'ecg_list',to:'ecg#ecg_list'
      get 'show',to:'ecg#show'
      post 'create',to:'ecg#create'
      get 'delete',to:'ecg#delete'
    end
  end

  resource :pacs_data do
    collection do
      post '/sync_result', to: 'pacs_data#sync_result'
      post '/sync_result_save', to: 'pacs_data#sync_result_save'
    end
  end


  resource :case do
    collection do
      get '/first_case', to:'case#first_case'
      get '/second_case', to:'case#second_case'
      get '/third_case', to:'case#third_case'
      get '/fourth_case', to:'case#fourth_case'
      get '/fifth_case', to:'case#fifth_case'
      get '/sixth_case', to:'case#sixth_case'
      get 'play_video', to:'case#play_video'
    end
  end
  #移动终端接口
  resource :mobile_terminal do
    collection do
      get '/baby_reports', to: 'mobile_terminal#baby_reports'
      get '/baby_pictures', to: 'mobile_terminal#baby_pictures'
      get '/baby_videos', to: 'mobile_terminal#baby_videos'
      get '/baby_ultrasounds', to: 'mobile_terminal#baby_ultrasounds'
    end
  end

  resources :weixins do
    collection do
      get 'login', to: 'weixins#login'
      post 'login_info', to: 'weixins#login_info'
      get 'login_already', to: 'weixins#login_already'
      get 'login_delete', to: 'weixins#login_delete'
      get 'user_info', to: 'weixins#user_info'
      get 'user_message', to: 'weixins#user_message'
      get 'notice_delete', to: 'weixins#notice_delete'
      get 'friend_agree', to: 'weixins#friend_agree'
      get 'friend_reject', to: 'weixins#friend_reject'
      get '/change_user', to: 'weixins#change_user'
      #医生患者注册
      get 'patient_register', to: 'weixins#patient_register'
      post 'register_patient', to: 'weixins#register_patient'
      get 'doctor_register', to: 'weixins#doctor_register'
      post 'register_doctor', to: 'weixins#register_doctor'
      get 'user_management', to: 'weixins#user_management'
      #推荐分享列表
      get 'shared', to: 'weixins#shared'
      #查看分享文章
      get 'article', to: 'weixins#article'
      #健康档案
      get 'health_record', to: 'weixins#health_record'
      get 'patient_health_record', to: 'weixins#patient_health_record'
      get 'ultrasound', to: 'weixins#ultrasound'
      get 'reports', to: 'weixins#reports'
    end
  end
  #微信患者用户
  resources :weixin_patient do
    collection do
      #我的医生菜单（包含预约功能）
      get 'my_doctor',to: 'weixin_patient#my_doctor'
      get 'doctor', to: 'weixin_patient#doctor'
      get 'appointment', to: 'weixin_patient#appointment'
      post 'appointment', to: 'weixin_patient#appointment_data'

      get 'appointment_doctor',to: 'weixin_patient#appointment_doctor'
      #get 'appointment', to: 'weixin_patient#appointment'
      get 'my_appointment', to: 'weixin_patient#my_appointment'
      #post 'appointment', to: 'weixin_patient#appointment_data'

      #健康档案菜单
      get 'health_record', to: 'weixin_patient#health_record'
      get 'health_record_list', to: 'weixin_patient#health_record_list'
      get 'patient_health_record', to: 'weixin_patient#patient_health_record'
      get 'ultrasound', to: 'weixin_patient#ultrasound'
      get 'reports', to: 'weixin_patient#reports'
      get 'ct', to: 'weixin_patient#ct'
      get 'send_health_tempate_message',to:'weixin_patient#send_health_tempate_message'
      post 'send_health_tempate_message',to:'weixin_patient#send_health_tempate_message'
      #我 菜单
      ##账户管理
      get 'login', to: 'weixin_patient#login'
      get 'login_form', to: 'weixin_patient#login_form'
      post 'submit_login',to:'weixin_patient#submit_login'
      post 'login_send_message',to:'weixin_patient#login_send_message'
      post 'register_send_message',to:'weixin_patient#register_send_message'
      # post 'login_info', to: 'weixin_patient#login_info'
      get 'home', to: 'weixin_patient#home'
      get 'change_user', to: 'weixin_patient#change_user'
      post 'login_delete', to: 'weixin_patient#login_delete'
      # get 'patient_register', to: 'weixin_patient#patient_register'
      # post 'register_patient', to: 'weixin_patient#register_patient'
      get 'show_patient_register',to:'weixin_patient#show_patient_register'
      post 'create_patient_register',to:'weixin_patient#create_patient_register'
      post 'check_phone_code',to:'weixin_patient#check_phone_code'


      ##消息提醒
      get 'user_message', to: 'weixin_patient#user_message'
      get 'notice_delete', to: 'weixin_patient#notice_delete'
      get 'friend_agree', to: 'weixin_patient#friend_agree'
      get 'friend_reject', to: 'weixin_patient#friend_reject'
      get '/change_user', to: 'weixin_patient#change_user'
      ##推荐文章
      get 'shared', to: 'weixin_patient#shared'
      get 'article', to: 'weixin_patient#article'
    end
  end
#   新瑞时智能健康网关“尔康”数据接口
  resource :lanya do
    collection do
      get 'show',to:'lanya#show'
      post 'upload',to:'lanya#upload'
        # post 'upload/wt/901/0/3',to:'lanya#add_weight'
      # post 'upload/bp/201/1/3',to:'lanya#add_pressure'
      # post 'upload/ecg/301/1/3',to:'lanya#add_ecg'
      post  'add_ecg',to:'lanya#add_ecg'
      post  'add_ecg2',to:'lanya#add_ecg2'
      post 'add_glucose',to:'lanya#add_glucose'
      post 'add_weight',to:'lanya#add_weight'
      post 'add_pressure',to:'lanya#add_pressure'
      post 'add_oxygen',to:'lanya#add_oxygen'

    end
  end

  resources :mobile_app do
    collection do
      get 'yunjian_1'
      get 'yunjian_2'
      get 'yunjian_3'
      get 'yunjian_4'
      get 'yunjian_5'
      get 'yunjian_6'
      get 'yunjian_7'
      get 'yunjian_8'
      get 'yunjian_9'
      get 'yunjian_10'
      get 'yunjian_11'
      get 'yunjian_12'
      get 'yunjian_13'
      get 'yunjian_14'
    end
  end
  resources :website_agreements do
    collection do
      get 'show', to: 'website_agreements#show'
    end
  end
  #为健康档案后台上传提供接口
  resources :archive_queue do
    collection do
      get 'all', to: 'archive_queue#all'
      post 'delete_queue', to: 'archive_queue#delete_queue'
      post 'add_report', to: 'archive_queue#add_report'
      post 'update_status', to: 'archive_queue#update_status'
      post 'send_message_to_weixin', to: 'archive_queue#send_message_to_weixin'
    end
  end
  resources :block_content do
       collection do
         get 'show',to:'block_content#show'
         get 'list',to:'block_content#list'
       end
  end

  resource :diagnose_treat do
    collection do
      get 'show',to:'diagnose_treat#show'
      post 'create',to:'diagnose_treat#create'
      post 'destroy',to:'diagnose_treat#destroy'
      get 'show_treat_right',to:'diagnose_treat#show_treat_right'
      post 'teller',to:'diagnose_treat#teller'
      post 'diagnose',to:'diagnose_treat#diagnose'
      post 'doctor_order_create',to:'diagnose_treat#doctor_order_create'
      get 'destroy_doctor_order',to:'diagnose_treat#destroy_doctor_order'
      post 'diagnose_treat_update',to:'diagnose_treat#diagnose_treat_update'
      post 'diagnose_health_reports',to:'diagnose_treat#diagnose_health_reports'
      post 'show_according',to:'diagnose_treat#show_according'
      post 'update_reports',to:'diagnose_treat#update_reports'
      post 'doctor_order_update',to:'diagnose_treat#doctor_order_update'
      get 'get_advices', to: 'diagnose_treat#get_advices'
      get 'get_diagnoses', to: 'diagnose_treat#get_diagnoses'
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
