Rails.application.routes.draw do
  root 'post#index'

  get 'post/index', defaults: {format: 'json'}
  # put '/post', to: 'post#update', constrains: {format: 'json'}
  # get '/post/:id', to: 'post#show', constrains: {format: 'json'}

  resources :post, only: [:create, :index, :update, :show], defaults: {format: :json}  do
    put :like, on: :collection
    get :page, on: :collection, constrains: {format: 'json'}
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
