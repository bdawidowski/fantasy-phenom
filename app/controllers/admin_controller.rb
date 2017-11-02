class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin?
    before_action :user_params, only: [:update, :import]
    def index
        @users = User.where(:removed => false)
        @subscriptions = Standing.all
    end

    def edit
        @user = User.find(params[:id])
    end
    
    def update
        require 'date'
        @user = User.find(params[:id])
        
        if @user.update(user_params)
            rocket_server = RocketChat::Server.new('https://fantasy-phenom.rocket.chat')
            rocket_session = rocket_server.login("admin", Rails.application.secrets.rocket_pw)
            query_result = rocket_session.users.list(query: {email: @user.email})
            if params[:subscribed]
                if query_result && @user.rocket_token
                    rocket_session.users.update(@user.rocket_token, active: true)
                else
                    rocket_user = rocket_session.users.create(@user.email.sub(/@.*?$/, ""), @user.email, @user.first_name + " " + @user.last_name,  "fantasyphenom365",
                                         active: true, send_welcome_email: false)
                end
            else
                if query_result && @user.rocket_token
                    rocket_session.users.update(@user.rocket_token, active: false)
                end
            end
            
            flash[:success] = "You updated #{@user.email} Successfully"
            redirect_to admin_index_path
        else
            render :edit
        end
    end
    def import
        User.import(params[:file])
        flash[:success] = "Import Successfully"
        redirect_to admin_index_path
    end
    def rocket_users
        @users = User.all
        rocket_server = RocketChat::Server.new('https://fantasy-phenom.rocket.chat')
        rocket_session = rocket_server.login("admin", Rails.application.secrets.rocket_pw)
        @users.each do |user|
            query_result = rocket_session.users.list(query: {email: user.email})
            if user.subscribed && !query_result
                    rocket_user = rocket_session.users.create(user.email.sub(/@.*?$/, ""), user.email, user.first_name + " " + user.last_name,  "fantasyphenom365",
                                         active: true, send_welcome_email: false)
                    rocket_token = rocket_session.users.create_token(user_id: rocket_user.id)
                    rocket_token = rocket_token.user_id
                    user.update(
                        chatroom: true,
                        was_subscribed: true,
                        rocket_token: rocket_token,
                        rocket_pw: "fantasyphenom365"
                    )
            elsif user.subscribed && query_result && user.rocket_token == nil
                rocket_token = rocket_session.users.create_token(user_id: query_result[0].id)
                rocket_token = rocket_token.user_id
                user.update(
                    chatroom: true,
                    was_subscribed: true,
                    rocket_token: rocket_token,
                    rocket_pw: "fantasyphenom365"
                )
            elsif query_result && !user.subscribed
                rocket_session.users.update(user.rocket_token, active: false)
                user.update(chatroom: false)
            elsif query_result && user.subscribed
                rocket_session.users.update(user.rocket_token, active: true)
                user.update(chatroom: true)
            end
        end
        flash[:success] = "Rocket Sync Complete!"
        redirect_to admin_index_path
    end
    private
        def user_params
            params.permit(:subscribed, :contributor, :chatroom, :editor, :paypal, :file, :removed)
        end
    
end
