class Api::V1::UsersController < ApplicationController
    before_action :authentication_with_token!, only: [:update, :destroy]
    respond_to :json

    def show
        begin
          @user = User.find(params[:id])
    
          respond_with @user
        rescue
          head 404
        end
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: 201
      else
        render json: { errors: user.errors}, status: 422
      end
    end
 
    def update
      user = current_user
      
      if user.update(user_params)
        render json: user, status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    end

    def destroy
      current_user.destroy
      head 204
    end

  
  private

  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

