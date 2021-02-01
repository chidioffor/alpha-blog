Rails.application.routes.draw do
	root 'pages#home'
	get 'about', to: 'pages#about'
	resources :articles
	get 'signup', to: 'users#new'
	resources :users, except: [:new]
	
	#post 'users', to: 'users#create'
	# below has same effect as (resources :articles), 
	# but shows how to selectively expose rails routes 
	#resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy] 
end
