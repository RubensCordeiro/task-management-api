# frozen_string_literal: true

class AuthenticationTokenService
  HMAC_SECRET = ENV.fetch('TOKEN_SECRET', nil)
  ALGORITHM = 'HS256'

  def self.encode(payload)
    JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM })
  end
end
