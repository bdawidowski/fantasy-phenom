class SubscriptionsController < ApplicationController
    before_action :authenticate_user!, except: [:new]
    before_action :redirect_to_signup, only: [:new]
    
    def new
    end
    def create
        if params[:stripeToken] and params[:card_last4]
            customer =  if current_user.stripe_id?
                            Stripe::Customer.retrieve(current_user.stripe_id)
                        else
                            Stripe::Customer.create(
                                email: current_user.email
                                )
                        end
            subs = customer.subscriptions.create(
                source: params[:stripeToken],
                plan: '102'
            )
            if current_user.rocket_token.nil?
                generated_rocket_pw = (0...8).map { (65 + rand(26)).chr }.join
                rocket_server = RocketChat::Server.new('https://fantasy-phenom.rocket.chat')
                rocket_session = rocket_server.login("admin", Rails.application.secrets.rocket_pw)

                user = rocket_session.users.create((0...8).map { (65 + rand(26)).chr }.join, current_user.email, current_user.first_name + " " + current_user.last_name,  generated_rocket_pw,
                                     active: true, send_welcome_email: true)
                rocket_token = rocket_session.users.create_token(user_id: user.id)
                rocket_token = rocket_token.user_id
                NotifyAdminEmail.new_subscriber(current_user).deliver
            else
                generated_rocket_pw = current_user.rocket_pw
                rocket_token = current_user.rocket_token
            end

            current_user.update(
                stripe_id: customer.id,
                stripe_subscription_id: subs.id,
                card_type: params[:card_brand],
                card_last4: params[:card_last4],
                card_exp_month: params[:card_exp_month],
                card_exp_year: params[:card_exp_year],
                subscribed: true,
                was_subscribed: true,
                rocket_token: rocket_token,
                rocket_pw: generated_rocket_pw,
                amount: "9.99"
            )
            flash[:success] = "You have successfull subscribed!"
            redirect_to root_path
        else
            flash[:danger] = "Something went wrong subscribed!"
            redirect_to new_subscription_path
        end
    end
    def edit
    end
    def update
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        subs = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
        
        rocket_server = RocketChat::Server.new('https://fantasy-phenom.rocket.chat')
        rocket_session = rocket_server.login('admin', Rails.application.secrets.rocket_pw)
        
        if params[:to_delete] === "true"
            current_user.update(
                subscribed: false,
                contributor: false
            )
            subs.delete
            rocket_session.users.update(current_user.rocket_token, active: false)
            
            NotifyAdminEmail.stripe_unsubscriber(current_user).deliver
            flash[:warning] = "You have canceled your Pro Account!"
            redirect_to account_path
        elsif params[:to_delete] === "paypal"
            current_user.update(
                subscribed: false,
                contributor: false
            )
            
            rocket_session.users.update(current_user.rocket_token, active: false)

            NotifyAdminEmail.paypal_unsubscriber(current_user).deliver
            flash[:warning] = "You have canceled your Pro Account! May take up to 24 hours to recieve notice from PayPal"
            redirect_to account_path
        else
            subs = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
            subs.source = params[:stripeToken]
            subs.save
        
            current_user.update(
                card_type: params[:card_brand],
                card_last4: params[:card_last4],
                card_exp_month: params[:card_exp_month],
                card_exp_year: params[:card_exp_year]
            )
            if subs
                flash[:success] = "You have successfull Updated Card Information!"
                redirect_to account_path
            else
                render :edit
            end
        end
    end
    def account
    end
    def platform
    end
    private
        def redirect_to_signup
            if !user_signed_in?
                session["user_return_to"] = new_subscription_path
                redirect_to new_user_registration_path
            end
        end
        
end





























