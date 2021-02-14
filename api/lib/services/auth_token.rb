class AuthToken

  def self.generate(user)
    token, payload = user_encoder.call(
        user, devise_scope(user), aud_headers
    )
    token
  end

  private

  def self.devise_scope(user)
    Devise::Mapping.find_scope!(user)
  end

  def self.user_encoder
    Warden::JWTAuth::UserEncoder.new
  end

  def self.aud_headers
    token_headers[Warden::JWTAuth.config.aud_header]
  end

  def self.token_headers
    {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
    }
  end
end
