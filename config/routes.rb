Rails.application.routes.draw do
  get 'upload_inspect_informations/upload'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: 'static_pages#home'
  post '/store_log', to: 'static_pages#store_log'

  get  '/upload', to: 'upload_inspect_informations#upload'
  post '/upload', to: 'upload_inspect_informations#store_and_analysis'

end
