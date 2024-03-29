class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @reviews = @user.reviews
        @favorite_movies = @user.favorite_movies
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(users_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "Thanks for signing up!"
        else
            render :new, status: :unprocessable_entity
        end

    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(users_params)
            redirect_to @user, notice: "Account successfully updated!"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
        redirect_to movies_url, status: :see_other, alert: "Account Deleted"
    end



    private

    def users_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def require_correct_user
        @user = User.find(params[:id])
        redirect_to movies_url unless current_user?(@user)
    end

end
