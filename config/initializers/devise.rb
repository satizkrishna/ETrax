Devise.setup do |config|

  config.mailer_sender = 'noreply@etrax.com'

  require 'devise/orm/active_record'

  config.http_authenticatable = [:token]

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth, :token_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 3.hours

end

Devise::TokenAuthenticatable.setup do |config|

  config.token_expires_in = 1.day
  config.token_authentication_key = :authentication_token
  config.should_reset_authentication_token = true
  config.should_ensure_authentication_token = true

end