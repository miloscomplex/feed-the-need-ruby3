Rails.application.routes.draw do
  
  root 'welcome#index'


  get '/login', to: 'sessions/sessions#login', as: 'login'
  post '/login', to: 'sessions/sessions#create'

  get '/logout', to: 'sessions/sessions#logout', as: 'logout'

  resources :needies, controller: 'needies/users', path: 'needy', except: [:index] do
    resource :items, controller: 'needies/items'
  end

  resources :donators, controller: 'donators/users' do
    post '/donate_items', to: 'donators/needies#donate_items', as: 'donate_items'
    resources :needies, controller: 'donators/needies', only: [:index, :show], path: 'needy'
    resources :items, controller: 'donators/items', only: [:index]
    # define custom routes since it should be displayed and edited as a set?
  end

  get '/auth/google_oauth2/callback', to: 'sessions/sessions#google_login'

end
