class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update]
   def index
     users = User.all
     render json: users
   end

   def update
     find_book
     @user.update(user_params)
     if @user.save
       render json: @user, status: :accepted
     else
       render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
     end
   end

   def show
     find_user
     authenticateGoogleDrive()
     render json: @user

   end

   def create
     @user = User.new(user_params)
     @user.save
   end

   private

   def user_params
     params.require(:user).permit(:name)
   end

   def find_user
     @user = User.find(params[:id])
   end
 end
