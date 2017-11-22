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
            if @user.rocket_token
                query_result = rocket_session.users.info(user_id: user.rocket_token) 
            else
                query_result = false
            end
            if params[:subscribed] != ''
                if @user.rocket_token
                    rocket_session.users.update(@user.rocket_token, active: true)
                elsif !query_result && rocket_session.users.info(username: @user.email.sub(/@.*?$/, ""))
                    rtoken = rockey_sesson.users.create_token(user_id: query_result.id)
                    @user.update(rocket_token: rtoken)
                    rocket_session.users.update(rtoken, active: true)
                else
                    rocket_user = rocket_session.users.create(@user.email.sub(/@.*?$/, ""), @user.email, @user.first_name + " " + @user.last_name,  "fantasyphenom365",
                                         active: true, send_welcome_email: true)
                end
            else
                if @user.rocket_token
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
    def export
        respond_to do |format|
            format.html
            format.csv {send_data User.export}
        end
        flash[:success] = "Export Successfully"
    end
    def rocket_users
        @users = User.all
        rocket_server = RocketChat::Server.new('https://fantasy-phenom.rocket.chat')
        rocket_session = rocket_server.login("admin", Rails.application.secrets.rocket_pw)
        @users.each do |user|
            if user.rocket_token
                query_result = rocket_session.users.info(user_id: user.rocket_token) 
            else
                query_result = false
            end
            if user.subscribed && !query_result
                if rocket_session.users.info(username: user.email.sub(/@.*?$/, ""))
                    rocket_token = rocket_session.users.create_token(user_id: query_result.id)
                    rocket_token = rocket_token.user_id
                    user.update(
                        chatroom: true,
                        was_subscribed: true,
                        rocket_token: rocket_token,
                        rocket_pw: "fantasyphenom365"
                    )
                else
                    rocket_user = rocket_session.users.create(user.email.sub(/@.*?$/, ""), user.email, user.first_name + " " + user.last_name,  "fantasyphenom365",
                                         active: true, send_welcome_email: true)
                    rocket_token = rocket_session.users.create_token(user_id: rocket_user.id)
                    rocket_token = rocket_token.user_id
                    user.update(
                        chatroom: true,
                        was_subscribed: true,
                        rocket_token: rocket_token,
                        rocket_pw: "fantasyphenom365"
                    )
                end
            elsif query_result && !user.subscribed && user.rocket_token
                rocket_session.users.update(user.rocket_token, active: false)
                user.update(chatroom: false)
            elsif query_result && user.subscribed && user.rocket_token
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
