Rails.application.routes.draw do
  root 'pages#home'
  resources :articles
  get 'pending-articles', to: 'articles#pending'
  put 'draft-submit/:id', to: 'articles#submit_draft', as: :submit_draft
  put 'approve/:id', to: 'articles#approve', as: :approve_article
  resources :users, except: [:new]
  resources :tags, except: [:show]
  get 'signup', to: 'users#new' # this will force the route shown to the user to be /signup instead of /user/new
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
