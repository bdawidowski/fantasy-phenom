class SendClientEmail < ApplicationMailer
    def ebook(contact)
        @contact = contact
        mail(to: @contact.email, subject: "FP365 DFS101 E-BOOK")
    end
end
