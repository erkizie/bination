# frozen_string_literal: true

Devise.setup do |config|

  config.jwt do |jwt|
    jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
    jwt.expiration_time = 86400 # 24 hours
    jwt.dispatch_requests = [ ['POST', %r{/graphql}] ]
  end

  config.secret_key = 'a97b66e9c1880fb25f79e60ddaa73e12a744ea63d8ff1f04468624982264e23c9f539de6f23761fa563444c02a5a561099157657b7c9cc13f7a3b429e832edd2'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
end
