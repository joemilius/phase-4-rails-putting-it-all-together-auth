class SessionsController < ApplicationController
    # before_action :authorize
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id 
            render json: user, status: :created
        else
            render json: {errors: ["Invalid username or passowrd"]}, status: :unauthorized
        end
    end

    def destroy
        # user = User.find_by(id: params[:id])
        if session[:user_id]
        session.delete :user_id
        head :no_content
        else
            render json: {errors: ["Not Authorized"]}, status: :unauthorized
        end
    end

    private
    
    # def authorize
    #     return render json: {error: "Not authorized"}, status: :unauthorized unless session.inlude? :user_id
    # end
end
