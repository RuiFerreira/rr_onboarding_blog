Rails.application.routes.draw do
  root 'pages#home'
  resources :articles
  get 'pending-articles', to: 'articles#pending'
  resources :users, except: [:new]
  get 'signup', to: 'users#new' # this will force the route shown to the user to be /signup instead of /user/new
end
