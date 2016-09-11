require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'fileutils'
include Log4r

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myplaceonline
  
  # The following section are mirrored in myplaceonline_final.js
  DEFAULT_DATE_FORMAT = "%A, %b %d, %Y"
  DEFAULT_TIME_FORMAT = "%A, %b %d, %Y %-l:%M:%S %p"
  JQM_DATEBOX_TIMEBOX_FORMAT = "%I:%M %p"
  DEFAULT_SUPPORT_EMAIL = "Myplaceonline.com <contact@myplaceonline.com>"
  # End mirrored constants

  DEFAULT_ROOT_EMAIL = "root@myplaceonline.com"
  
  class MyplaceonlineRequestStrategy
    def initialize(app)
      @app = app
    end
    
    def call(env)
      start_time = Time.now
      begin
        #Rails.logger.debug{"MyplaceonlineRequestStrategy entry"}
        ExecutionContext.push
        result = @app.call(env)
        result
      ensure
        ExecutionContext.clear
        #Rails.logger.debug{"MyplaceonlineRequestStrategy exit"}
        end_time = Time.now
        diff = (end_time - start_time) * 1000.0
        Rails.logger.debug{"Myplaceonline response time in milliseconds = #{diff}"}
      end
    end
  end

  
  class Application < Rails::Application
    config.middleware.insert_after(Rails::Rack::Logger, MyplaceonlineRequestStrategy)
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    puts "Starting @ #{Time.now.to_s} from #{Dir.pwd.to_s} by #{ENV['USER']}"
    
    begin
      log4r_config = YAML.load_file(File.join(File.dirname(__FILE__), "log4r.yml"))
      log4r_config['log4r_config']['outputters'].each do |outputter|
        if outputter['filename']
          outputter['filename'] = outputter['filename'].gsub("%u", ENV['USER'])
          if Rails.env.production?
            # may need to know for perms, etc
            puts "Changing configuration of log4r outputter to " + File.absolute_path(Dir.new(outputter["dirname"])) + "/" + outputter['filename']
          end
        end
      end
      YamlConfigurator.decode_yaml( log4r_config['log4r_config'] )
      config.logger = Log4r::Logger[Rails.env]
    rescue Exception => e
      puts "Error configuring log4r #{e}"
    end
    
    # http://stackoverflow.com/a/5015920/4135310
    config.before_configuration do
      I18n.locale = :en
      I18n.load_path += Dir[Rails.root.join('config', 'locales', 'en.yml').to_s]
      I18n.reload!
    end

    config.autoload_paths += %W(#{config.root}/lib)

    #config.tmpdir = ENV["TMPDIR"].blank? ? Dir.tmpdir : ENV["TMPDIR"]
    config.tmpdir = Rails.root.join("tmp", "myp").to_s
    config.filetmpdir = Rails.root.join("tmp", "myp", "files").to_s
    if !ENV["PERMDIR"].blank?
      config.filetmpdir = ENV["PERMDIR"] + "uploads"
    end

    FileUtils.mkdir_p(config.tmpdir)
    FileUtils.mkdir_p(config.filetmpdir)

    config.active_record.raise_in_transactional_callbacks = true
    
    config.active_job.queue_adapter = :delayed_job
    
    # http://ruby-doc.org/core-2.2.0/Time.html#method-i-strftime
    # http://api.rubyonrails.org/classes/Time.html
    # http://api.rubyonrails.org/classes/DateTime.html
    Date::DATE_FORMATS[:default] = Myplaceonline::DEFAULT_DATE_FORMAT
    Time::DATE_FORMATS[:default] = Myplaceonline::DEFAULT_TIME_FORMAT
    
    Time::DATE_FORMATS[:month_year] = "%B %Y (%m/%y)"
    Time::DATE_FORMATS[:simple_date] = Myplaceonline::DEFAULT_DATE_FORMAT
    Time::DATE_FORMATS[:short_date] = "%b %d"
    Time::DATE_FORMATS[:short_date_year] = "%b %d, %Y"
    Time::DATE_FORMATS[:short_datetime] = "%b %d %l:%M%p"
    # http://dev.jtsage.com/jQM-DateBox/api/timeOutput/
    Time::DATE_FORMATS[:timebox] = Myplaceonline::JQM_DATEBOX_TIMEBOX_FORMAT
    Time::DATE_FORMATS[:simple_time] = "%I:%M %p"
    
    # http://www.iso.org/iso/iso8601
    Date::DATE_FORMATS[:iso8601] = "%Y-%m-%d"
    Time::DATE_FORMATS[:iso8601] = "%Y-%m-%d"
    
    Date::DATE_FORMATS[:dygraph] = "%Y-%m-%d"
    Time::DATE_FORMATS[:dygraph] = "%Y-%m-%d %H:%M:%S"
  end
end
