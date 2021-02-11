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

	#routes for managing user login/logout sessios
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'
	resources :categories, except: [:destroy]
	
end
