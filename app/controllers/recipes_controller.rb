class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy, :add_info, :add_direction]
	before_action :authenticate_user!, except: [:index, :show]
	def index
		if params[:category].blank?
			@recipes = Recipe.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@recipes = Recipe.where(category_id: @category_id).order("created_at DESC")
		end
	end

	def show
		@info = @recipe.informations.build
		@direction = @recipe.directions.build

		@information_all = @recipe.informations.where.not(id: nil)
		@direction_all = @recipe.directions.where.not(id: nil)
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

	def upvote_direction
		@direction = Direction.find(params[:id])
		@direction.upvote_by current_user
		redirect_to :back
	end

	def downvote_direction
		@direction = Direction.find(params[:id])
		@direction.downvote_from current_user
		redirect_to :back
	end

	def add_info
		@new_info = @recipe.informations.build(url: params[:information][:url]) #, recipe_id: @recipe.id
		@new_info.save
		redirect_to :back
	end

	def add_direction
		@new_direction = @recipe.directions.build(step: params[:direction][:step]) #, recipe_id: @recipe.id
		@new_direction.save
		redirect_to :back
	end

	private

	def recipe_params
		params.require(:recipe).permit(:category_id, :title, :description, informations_attributes: [:id, :url, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
