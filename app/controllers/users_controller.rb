class UsersController < ApplicationController
	before_action :select_user, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:show, :index, :new, :create]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def index
		@users = User.all.order('created_at desc').paginate(page: params[:page], per_page: 4)	
	end

	def new
		@user = User.new	
	end

	def create
			  #render plain: params[:article]
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome to AlphaBlog. #{@user.username} has successfully been signed up!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@articles = @user.articles.order('created_at desc').paginate(page: params[:page], per_page: 4)
	end

	def edit

	end

	def update
		if @user.update(user_params)
			flash[:notice] = "#{@user.username.downcase}'s account information was successfully updated"
			redirect_to @user
		else 
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil if @user == current_user
		flash[:notice] = "Account and all associated articles deleted successfully."
		redirect_to root_path
	end

	# Private parameters below
	private

	def select_user
	  @user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username, :email, :password, :avatar)	
	end

	def require_same_user
		if !logged_in? && ((current_user != @user) || !current_user.admin?)
			flash[:alert] = "You can only edit/delete your own profile when logged in."
			redirect_to current_user
		end
	end

end