Rails.application.routes.draw do
  get 'welcome/index'
  get 'api/index'
  get 'api/categories'

  get 'meaning/index'
  get 'meaning', :to => 'meaning#index'

  get 'order/index'
  get 'order', :to => 'order#index'

  get 'joy/index'
  get 'joy', :to => 'joy#index'

  get 'search/index'
  get 'search', :to => 'search#index'

  get 'contact/index'
  get 'contact', :to => 'contact#index'
  
  get 'passwords/import'
  match 'passwords/import/odf', :to => 'passwords#importodf', via: [:get, :post]
  match 'passwords/import/odf/:id/step1', :to => 'passwords#importodf1', via: [:get, :post], :as => "passwords_import_odf1"
  resources :passwords
  post 'passwords/new'
  get 'passwords', :to => 'passwords#index'

  devise_scope :user do
    match 'users/reenter', :to => 'users/sessions#reenter', via: [:get, :post]
    post 'users/sign_up', :to => 'users/registrations#new'
    get 'users/delete', :to => 'users/registrations#delete'
    match 'users/password/change', :to => 'users/registrations#changepassword', via: [:get, :put]
    match 'users/changeemail', :to => 'users/registrations#changeemail', via: [:get, :put]
    match 'users/resetpoints', :to => 'users/registrations#resetpoints', via: [:get, :post]
  end

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    #omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  root 'welcome#index'
end
