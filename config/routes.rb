Rails.application.routes.draw do
  resources :polls do
    resources :users do
      resources :time_frames
      resources :comments
    end
  end
  get 'index/index'
  get '/polls/id/:poll_id', to: "polls#get_poll_by_poll_id"
  root "index#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
