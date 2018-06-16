module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    uEmail=user.email
    if uEmail.empty?
      uEmail="test@gmail.com"
    end
    gravatar_id = Digest::MD5::hexdigest(uEmail)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
