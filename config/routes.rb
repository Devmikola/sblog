Rails.application.routes.draw do

  get 'static_pages/home'
  get 'static_pages/help'

  match 'comments/:comment_id/destroy', to: 'comments#destroy', via: 'delete', as: 'delete_comment'
  match 'comments/:comment_id/update_comment', to: 'comments#update', via: 'patch', as: 'update_comment'
  match 'posts/:post_id/new_comment', to: 'comments#create', via: 'post', as: 'new_comment'
  match 'posts/:post_id/new_comment/:parent_id', to: 'comments#create', via: 'post', as: 'new_child_comment'

  resources :posts
  get 'posts/new'
  get 'personal_blog/:name', to: 'posts#personal_blog', as: 'personal_blog'

  resources :users
  get 'users/new'

  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

end
