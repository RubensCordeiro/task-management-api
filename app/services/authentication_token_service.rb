# frozen_string_literal: true

class AuthenticationTokenService
  HMAC_SECRET = ENV['TOKEN_SECRET']
  ALGORITHM = 'HS256'

  def self.encode(payload)
    byebug
    token = JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM })
  end
end
