# frozen_string_literal: true

Devise.setup do |config|

  config.jwt do |jwt|
    jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
    jwt.expiration_time = 3600 # 1 hour
    jwt.dispatch_requests = [ ['POST', %r{/graphql}] ]
  end

  config.secret_key = '033c351fccb934aea78d5b78337b7a924be18a099aa977242fb767d4b2fe35af309dfe6db826df5792e2ee6017bf4a249a554df625eaabe725ec0ce5443c1402'

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
