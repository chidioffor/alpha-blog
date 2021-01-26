class ArticlesController < ApplicationController
	
	before_action :select_article, only: [:show, :edit, :update, :destroy]

	def show

	end

	def index
		@articles = Article.all.order('created_at desc').paginate(page: params[:page], per_page: 4)
	end

	def new
	  @article = Article.new
	end

	def edit

	end

	def create
	  #render plain: params[:article]
		@article = Article.new(article_params)
		if @article.save
			flash[:notice] = "Article was successfully saved"
			redirect_to @article
			#redirect_to article_path(@article) # Same as redirect_to @article
			#render plain: @article.inspect # displays ob browser what is parsed to database model
		else
			render 'new'
		end
	end

	def update
		if @article.update(article_params)
			flash[:notice] = "Article was successfully saved"
			redirect_to @article
		else 
			render 'edit'
		end
	end

	def destroy
		@article.destroy 
		redirect_to articles_path
	end

	private

	def select_article
	  @article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)	
	end

end
