Rails.application.routes.draw do
  root to: 'customers#index'

  #管理者アカウント
  devise_for :admins, controllers: {
    registrations: 'admins/registrations'
  }
  resources :admins, only: [:show]
  #ユーザーアカウント
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  #ワーカーアカウント
  devise_for :workers, controllers: {
    registrations: 'workers/registrations',
    sessions: 'workers/sessions',
    confirmations: 'workers/confirmations',
    passwords: 'workers/passwords',
  }
  resources :workers, only: [:show]

  resource :sender, only: [:show]
  post 'senders/import' => 'senders#import'
  #センダーアカウント
  devise_for :senders, controllers: {
    registrations: 'senders/registrations'
  }

  resources :inquiries, only: [:index, :show, :edit, :update, :destroy] 

  resources :senders, only: [:index, :show, :edit, :update] do
    resources :inquiries, except: [:index, :show, :edit, :update, :destroy] do
      put :default, to: 'inquiries#default'
    end
    get 'history', to: 'senders_history#index'
    get 'sended', to: 'senders_history#sended'
    get 'mail_app', to: 'senders_history#mail_app'
    get 'tele_app', to: 'senders_history#tele_app'
    get 'download_sended', to: 'senders_history#download_sended'
    get 'download_callbacked', to: 'senders_history#download_callbacked'
    get 'callbacked', to: 'senders_history#callbacked'
    get 'users_callbacked', to: 'senders_history#users_callbacked'
    post 'okurite/autosettings', to: 'okurite#autosettings'
    delete 'bulk_delete', to: 'okurite#bulk_delete'
    # okurite
    resources :okurite, only: [:index, :show] do
      get :preview, to: 'okurite#preview'
      post :contact, to: 'okurite#create'

    end
  end
  get 'callback' => 'okurite#callback', as: :callback
  get 'direct_mail_callback' => 'okurite#direct_mail_callback', as: :direct_mail_callback

  resources :sendlist
  resources :estimates, only: [:index, :show] do
    member do
      get :report
    end
  end

  resources :customers do
    resources :calls
    collection do
      get :complete
      post :import
      post :update_import
      post :call_import
      post :tcare_import
      get :message
    end
  end

  get 'list' => 'customers#list'
  get 'customers/:id/:is_auto_call' => 'customers#show'
  get 'direct_mail_send/:id' => 'customers#direct_mail_send' #SFA
  #get 'sender/:id/' => 'sender#show'
  scope :information do
    get '' => 'customers#information', as: :information #分析
  end

  get 'closing' => 'customers#closing' #締め
  get 'news' => 'customers#news' #インポート情報
  get 'extraction' => 'customers#extraction' #TCARE
  delete :customers, to: 'customers#destroy_all' #Mailer
  get 'manuals' => 'manuals#index'
  get 'manuals/officework' => 'manuals#officework'


  # エラー情報
  get 'pybot' => 'pybot_e_notify#index'
  get 'pybot/destroy' => 'pybot_e_notify#destroyer'

  # API
  namespace :api do
    namespace :v1 do
      resources :smartphones
      namespace :smartphone_logs do
        post '/' , :action => 'create'
      end
      resources :pybotcenter 
      get "pybotcenter_success" => "pybotcenter#success"
      get "pybotcenter_failed" => "pybotcenter#failed"
      post "autoform_data_register" => "pybotcenter#graph_register"
      post "pycall" => "pybotcenter#notify_post"
      get "inquiry" => "pybotcenter#get_inquiry"
    end
  end

  resources :contracts do
    resources :images, only: [:create, :destroy, :update, :download, :edit]
    resources :knowledges
    member do
      get 'images/view'
      get 'images/download/:id' => 'images#download' ,as: :images_pdf
    end
  end

  get '*path', controller: 'application', action: 'render_404'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
