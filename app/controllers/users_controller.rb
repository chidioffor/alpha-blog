class UsersController < ApplicationController
	before_action :select_user, only: [:show, :edit, :update, :destroy]

	def new
		@user = User.new	
	end

	def create
			  #render plain: params[:article]
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to AlphaBlog. #{@user.username} has successfully been signed up!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		# @articles = @user.articles
		@articles = @user.articles.order('created_at desc').paginate(page: params[:page], per_page: 4)
	end

	def edit

	end

	def update
		if @user.update(user_params)
			flash[:notice] = "#{@user.username.downcase}'s account information was successfully updated"
			redirect_to articles_path
		else 
			render 'edit'
		end
	end

	def destroy
		
	end

	# Private parameters below
	private

	def select_user
	  @user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username, :email, :password, :avatar)	
	end

end