Rails.application.routes.draw do



  get 'uploader/index'
  get 'uploader/form'
 post 'uploader/upload'
  get 'uploader/download'

                                        #ログイン切り替え
  devise_for :admins
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


                                            #問い合わせフォーム

  get 'contact' => 'contact#index'
  post 'contact/confirm' => 'contact#confirm'
  post 'contact/thanks' => 'contact#thanks'


                                            #会社情報・就業情報
  resources :companies do
        #CSV
    collection do
        post :import
        get :message
    end
        #コメント
    resources :comments, only: [:create, :destroy, :update]
    member do
      get :progress
    end
 end

                                            #都道府県
    resources :prefectures
                                                #請求書
    resources :invoices do
      member do
        get :report
      end
    end

                                                 #就業規則
    resources :employments
    
    resources :todos

                                                         #FAQ
  resources :faqs

                                                   #表側ページ
  get '/' => 'tops#subsidy'
  get '/company' => 'tops#company'
  get 'documents' => 'documents#index'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end