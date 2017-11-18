class NotifyAdminEmail < ApplicationMailer
    def new_subscriber(user)
        @user = user
#        mail(to: "kyle@fantasy-phenom.com", subject: "New User Subscribed: #{@user.email}")
#        mail(to: "mike@fantasy-phenom.com", subject: "New User Subscribed: #{@user.email}")
        mail(to: "support@fantasy-phenom.com", subject: "New User Subscribed: #{@user.email}")
    end
    def stripe_unsubscriber(user)
        @user = user
#        mail(to: "kyle@fantasy-phenom.com", subject: "Stripe User Has Unsubscribed: #{@user.email}")
#        mail(to: "mike@fantasy-phenom.com", subject: "Stripe User Has Unsubscribed: #{@user.email}")
        mail(to: "support@fantasy-phenom.com", subject: "Stripe User Has Unsubscribed: #{@user.email}")
    end
    def paypal_unsubscriber(user)
        @user = user
#        mail(to: "kyle@fantasy-phenom.com", subject: "Paypal Cancel Requested: #{@user.email}")
#        mail(to: "mike@fantasy-phenom.com", subject: "Paypal Cancel Requested: #{@user.email}")
        mail(to: "support@fantasy-phenom.com", subject: "Paypal Cancel Requested: #{@user.email}")
    end
    def new_contact(contact)
        @contact = contact
#        mail(to: "kyle@fantasy-phenom.com", subject: "Question From: #{@contact.email}")
#        mail(to: "mike@fantasy-phenom.com", subject: "Question From: #{@contact.email}")
        mail(to: "support@fantasy-phenom.com", subject: "Question From: #{@contact.email}")
    end
    def new_lead(contact)
        @contact = contact
        mail(to: "support@fantasy-phenom.com", subject: "New Lead From Ebook: #{@contact.email}")
    end
end
