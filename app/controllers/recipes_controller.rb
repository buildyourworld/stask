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
		@contrelien = Contrelien.new
		@information_all = @recipe.informations
		@direction_all = @recipe.directions.where.not(id: nil)
	end

	def new
		@recipe = current_user.recipes.new
		@info = @recipe.informations.new
		@direction = @recipe.directions.new
	end

	def create
		@recipe = current_user.recipes.new(recipe_params)
		@info = @recipe.informations.new(title: params["recipe"]["information"]["title"], url: params["recipe"]["information"]["url"], user_id: current_user.id)
		@direction = @recipe.directions.new(title: params["recipe"]["direction"]["title"], url: params["recipe"]["direction"]["url"], step: params["recipe"]["direction"]["step"], user_id: current_user.id)

	    respond_to do |format|
	      if @recipe.save
	      	if not @info == nil
	      		@info.save
	      	end
	      	if not @direction == nil
	      		@direction.save
	      	end
	        format.html { redirect_to @recipe, notice: 'Image was successfully created.' }
	        format.json { render :show, status: :created, location: @recipe }
	      else
	        format.html { render :new }
	        format.json { render json: @recipe.errors, status: :unprocessable_entity }
	      end
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
		if current_user.id == @recipe.user_id
			@recipe.destroy
			redirect_to root_path, notice: "Successfully deleted recipe"
		else
			redirect_to :back, notice: "Not allowed"
		end
		# @recipe.informations.destroy_all
		# @recipe.directions.destroy_all
		
	end

	def destroy_info
		if current_user.id == Information.find(params[:id]).user_id
			Information.find(params[:id]).destroy
			redirect_to :back
		else
			redirect_to :back, notice: "Not allowed"
		end
	end

	def destroy_direction
		if current_user.id == Direction.find(params[:id]).user_id
			Direction.find(params[:id]).destroy
			redirect_to :back
		else
			redirect_to :back, notice: "Not allowed"
		end
	end

	def destroy_contreinfo
		if current_user.id == Contrelien.find(params[:id]).user_id
			Contrelien.find(params[:id]).destroy
			redirect_to :back
		else
			redirect_to :back, notice: "Not allowed"
		end
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
		@new_info = @recipe.informations.build(url: params[:information][:url], title: params[:information][:title], user_id: current_user.id) #, recipe_id: @recipe.id
		@new_info.save
		redirect_to :back
	end

	def add_contreinfo
		@information = Information.find(params[:info_id]) 
		@new_contreinfo = @information.contrelien.new(url: params[:contrelien][:url], title: params[:contrelien][:title], user_id: current_user.id)
		@new_contreinfo.save
		redirect_to :back
	end

	def add_direction
		@new_direction = @recipe.directions.build(title: params[:direction][:title], url: params[:direction][:url], step: params[:direction][:step], user_id: current_user.id) #, recipe_id: @recipe.id
		@new_direction.save
		redirect_to :back
	end

	private

	def recipe_params
		params.require(:recipe).permit(:category_id, :title, :description) #informations_attributes: [:id, :title, :url, :user_id, :_destroy], directions_attributes: [:id, :title, :user_id, :url, :step, :_destroy]
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
