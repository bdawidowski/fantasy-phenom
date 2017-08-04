class SubscriptionsController < ApplicationController
    before_action :authenticate_user!, except: [:new]
    before_action :redirect_to_signup, only: [:new]
    def new
    end
    def create
        customer =  if current_user.stripe_id?
                        Stripe::Customer.retrieve(current_user.stripe_id)
                    else
                        Stripe::Customer.create(
                            email: current_user.email
                            )
                    end
        subs = customer.subscriptions.create(
            source: params[:stripeToken],
            plan: "101"
        )
        
        current_user.update(
            stripe_id: customer.id,
            stripe_subscription_id: subs.id,
            card_type: params[:card_brand],
            card_last4: params[:card_last4],
            card_exp_month: params[:card_exp_month],
            card_exp_year: params[:card_exp_year]
        )
        if subs
            flash[:success] = "You have successfull subscribed!"
            redirect_to root_path
        else
            render :new
        end
    end
    def edit
    end
    def update
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
                   
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
            render :new
        end
    end
    def show
    end
    def destroy
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        subs = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
        subs.delete
        flash[:danger] = "You have canceled your Pro Account!"
        redirect_to root_path
    end
    def account
    end
    private
        def redirect_to_signup
            if !user_signed_in?
                session["user_return_to"] = new_subscription_path
                redirect_to new_user_registration_path
            end
        end
        
end
