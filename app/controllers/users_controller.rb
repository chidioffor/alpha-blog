class UsersController < ApplicationController
	before_action :select_user, only: [:show, :edit, :update, :destroy]

	def new
		@user = User.new	
	end

	def create
			  #render plain: params[:article]
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to AlphaBlog. #{@user.username} have successfully signed up!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end

	# Private parameters below
	private

	def select_user
	  @user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username, :email, :password)	
	end

end