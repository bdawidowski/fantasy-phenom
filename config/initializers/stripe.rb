Rails.configuration.stripe = {
    :publishable_key => Rails.application.secrets.stripe_public_key,
    :secret_key      => Rails.application.secrets.stripe_secret_key
}

Stripe.api_key = Rails.application.secrets.stripe_secret_key
class RecordCharges
    def call(event)
        charge = event.data.object
        user = User.find_by(stripe_id: charge.customer)
        c = user.charges.where(stripe_id: charge.id).first_or_create
        c.update(
            amount: charge.amount,
            card_last4: charge.source.last4,
            card_type: charge.source.brand,
            card_exp_month: charge.source.exp_month,
            card_exp_year: charge.source.exp_year,
            status: charge.status
        )
    end
end
class SubscriptionActivity
    def call(event)
        subscription = event.data.object
        user = User.find_by(stripe_id: subscription.customer)
        s = user.standing.where(stripe_id: subscription.id).first_or_create
        s.update(
            status: subscription.status,
            current_period_end: subscription.current_period_end,
            current_period_start: subscription.current_period_start,
            canceled_at: subscription.canceled_at
        )
    end
end

StripeEvent.configure do |events|
  events.subscribe 'charge.successed', RecordCharges.new
  events.subscribe 'charge.failed', RecordCharges.new
  events.subscribe 'customer.subscription.created', SubscriptionActivity.new
  events.subscribe 'customer.subscription.updated', SubscriptionActivity.new
  events.subscribe 'customer.subscription.deleted', SubscriptionActivity.new
end