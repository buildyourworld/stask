class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy, :add_info]
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def show
		@info = @recipe.informations.build
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	def upvote_info
		@info = Information.find(params[:id])
		@info.upvote_by current_user
		redirect_to :back
	end

	def downvote_info
		@info = Information.find(params[:id])
		@info.downvote_from current_user
		redirect_to :back
	end

	def add_info
		@new_info = @recipe.informations.build(url: params[:information][:url]) #, recipe_id: @recipe.id
		@new_info.save
		redirect_to :back
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, informations_attributes: [:id, :url, :_destroy], directions_attributes: [:id, :step, :destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
