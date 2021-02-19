Rails.application.routes.draw do
  resources :polls do
    resources :users do
      resources :time_frames
    end
  end
  get 'index/index'
  root "index#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
