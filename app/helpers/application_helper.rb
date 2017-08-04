module ApplicationHelper
    def gravatar_for(current_user, options = {size:80})
        gravatar_id = Digest::MD5::hexdigest(current_user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: current_user.email, class: "img-circle")
    end
end
