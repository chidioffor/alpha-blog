class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    before_action :select_category, only: [:show, :edit, :update, :destroy]
    def index
        @categories = Category.all.order('created_at desc').paginate(page: params[:page], per_page: 4)
    end

    def show
		@articles = @category.articles.order('created_at desc').paginate(page: params[:page], per_page: 4)
    end

    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "New category was successfully created"
            redirect_to @category
        else
            render 'new'
        end
    end

    def edit

    end

    def update
        if @category.update(category_params)
          flash[:notice] = "Category was successfully updated"
          redirect_to @category
        else
          flash[:alert] = "Following errors prevented this category from being saved"
          render 'edit'
        end
    end
    
    def destroy
        if @category.destroy
            flash[:notce] = 'Category was successfully deleted.'
            redirect_to categories_path
        else
            flash[:alert] = 'Following errors prevented this category from being deleted'
            redirect_to @category_path
        end
    end
    

    private

    def select_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "You must be logged in as admin to perform this action"
            redirect_to categories_path
        end
    end
    
end