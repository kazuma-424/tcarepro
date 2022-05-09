Rails.application.routes.draw do
  root to: 'top#index'
  get 'usp' => 'top#usp'
  get 'question' => 'top#question'
  get 'co' => 'top#co'

  get 'manuals' => 'manuals#index'
  get 'manuals/format' => 'manuals#format' #アポフォーマット
  get 'manuals/faq' => 'manuals#faq' #よくある質問
  get 'manuals/officework' => 'manuals#officework'

  get 'manuals/homework' => 'manuals#homework' #２回目の出勤について
  get 'manuals/first' => 'manuals#first' #１回目の出勤について
  get 'manuals/script' => 'manuals#script' #トークスクリプト
  get 'manuals/tool' => 'manuals#tool' #各種ツール紹介
  get 'manuals/document' => 'manuals#document' #各種ツール紹介

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
  #クライアントアカウント
  devise_for :clients, controllers: {
    registrations: 'clients/registrations'
  }
  resource :client, only: [:show]
  #センダーアカウント
  devise_for :senders, controllers: {
    registrations: 'senders/registrations'
  }
  resource :myself, only: :show, controller: :sender do
    resources :inquiries, only: [:index]
  end
  resources :senders, only: [:index, :show, :edit, :update] do
    resources :inquiries, except: [:index, :show] do
      put :default, to: 'inquiries#default'
    end
    get 'history', to: 'senders_history#index'
    get 'sended', to: 'senders_history#sended'
    get 'callbacked', to: 'senders_history#callbacked'
    # okurite
    resources :okurite, only: [:index, :show] do
      get :preview, to: 'okurite#preview'
      post :contact, to: 'okurite#create'
    end
  end
  get 'sender/question' => 'sender#question'
  get 'callback' => 'okurite#callback', as: :callback
  #ワーカーアカウント
  devise_for :workers, controllers: {
    registrations: 'workers/registrations',
    sessions: 'workers/sessions',
    confirmations: 'workers/confirmations',
    passwords: 'workers/passwords',
  }
  resources :workers, only: [:show]

  resources :matters #リスト案件情報
  resources :estimates, only: [:index, :show] do
    member do
      get :report
    end
  end

  resources :customers do
    resources :calls
    resources :counts
    collection do
      get :complete
      get :contact
      post :thanks
      post :import
      post :update_import
      post :call_import
      post :tcare_import
      get :message
      get :bulk_destroy
    end
  end

  get 'list' => 'customers#list'
  get 'customers/:id/:is_auto_call' => 'customers#show'

  scope :information do
    get '' => 'customers#information', as: :information #分析

    resource :incentive, only: [:show, :update], path: '/incentives/:year/:month'
  end

  get 'news' => 'customers#news' #インポート情報
  get 'export' => 'customers#export' #
  get 'sfa' => 'customers#sfa' #SFA
  #post 'customers/contact' => 'customers#contact' #メール送信
  #post 'customers/thanks' => 'ustomers#thanks' #メール送信完了
  get 'extraction' => 'customers#extraction' #TCARE
  delete :customers, to: 'customers#destroy_all' #Mailer

  #お問い合わせフォーム
  get 'contact' => 'contact#index'
  post 'contact/confirm' => 'contact#confirm'
  post 'contact/thanks' => 'contact#thanks'

  # API
  namespace :api do
    namespace :v1 do
      resources :smartphones
      namespace :smartphone_logs do
        post '/' , :action => 'create'
      end
    end
  end

  get '*path', controller: 'application', action: 'render_404'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
