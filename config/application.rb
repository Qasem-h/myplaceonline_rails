require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myplaceonline
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    puts "Starting @ " + Time.now.to_s

    config.autoload_paths += %W(#{config.root}/lib)
    
    config.require_invite_code = ENV["REQUIRE_INVITE_CODE"].nil? ? false : ENV["REQUIRE_INVITE_CODE"].to_bool
    
    config.invite_code = ENV["INVITE_CODE"].nil? ? "invitecode" : ENV["INVITE_CODE"]
  end
  
  def self.rememberPassword(session, password)
    session[:password] = password
  end
  
  def self.encryptFromSession(session, message)
    if !session.has_key?(:password)
      raise Myplaceonline::DecryptionKeyUnavailableError
    end
    return self.encrypt(message, session[:password])
  end
  
  def self.encrypt(message, key)
    result = EncryptedValue.new
    result.salt = SecureRandom.random_bytes(64)
    generated_key = ActiveSupport::KeyGenerator.new(key).generate_key(result.salt)
    crypt = ActiveSupport::MessageEncryptor.new(generated_key)
    result.val = crypt.encrypt_and_sign(message)
    return result
  end
  
  def self.decryptFromSession(session, encrypted_value)
    if !session.has_key?(:password)
      raise Myplaceonline::DecryptionKeyUnavailableError
    end
    return self.decrypt(encrypted_value, session[:password])
  end
  
  def self.decrypt(encrypted_value, key)
    generated_key = ActiveSupport::KeyGenerator.new(key)
            .generate_key(encrypted_value.salt)
    crypt = ActiveSupport::MessageEncryptor.new(generated_key)
    return crypt.decrypt_and_verify(encrypted_value.val)
  end
  
  class DecryptionKeyUnavailableError < StandardError; end
end
