class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin?
    before_action :user_params, only: [:update]
    def index
        @users = User.all
        @subscriptions = Standing.all
    end

    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "You updated #{@user.email} Successfully"
            redirect_to admin_index_path
        else
            render :edit
        end
    end
    private
        def user_params
            params.permit(:subscribed, :contributor, :chatroom)
        end
    
end
