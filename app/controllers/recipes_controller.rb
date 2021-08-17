class RecipesController < ApplicationController
    # rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
    wrap_parameters format:[]

    def index
        if session[:user_id]
            recipes = Recipe.all 
            render json: recipes, include: :user, status: :ok
        else
            render json: {errors: ["Invalid Id"]}, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            recipe = Recipe.new(recipe_params)
            recipe.user_id = session[:user_id]
            if recipe.save
                render json: recipe, include: :user, status: :created
            else
                render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {errors: ["Invalid Id"]}, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    # def invalid_response
    #     render json: {errors: valid.record.errors.full_messages }, status: :unprocessable_entity
    # end
end
