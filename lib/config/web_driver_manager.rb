require 'singleton'
require 'appium_capybara'
require 'site_prism'


class WebDriverManager
  class << self
  #   include Singleton

  #   def initialize
  #     @things = []
  #     @mutex  = Mutex.new
  #   end

  # def add(thing)
  #   with_mutex { @things << thing }
  # end

  # def things
  #   with_mutex { @things }
  # end

  # def clear
  #   with_mutex { @things.clear }
  # end

  # def self.add(thing)
  #   instance.add(thing)
  # end

  # def self.things
  #   instance.things
  # end

  # def self.clear
  #   instance.clear
  # end

  # private

  # def with_mutex
  #   @mutex.synchronize { yield }
  # end

    def initialize_driver

      case ENV['ENVIRONMENT']
      when 'web'
        Capybara.configure do |config|
            config.default_driver = :selenium
            config.run_server = false

            config.default_max_wait_time = 5
            config.default_selector = :css

            #config.app_host = 'http://www.example.com'#ENV['ENVIRONMENT_URL']
        end

        Capybara.register_driver :selenium do |app|
          case ENV['BROWSER_NAME'].downcase
          when 'firefox'
            Capybara::Selenium.Driver.new(app, browser: :firefox)
          when 'safari'
            Capybara::Selenium::Driver.new(app, browser: :safari)
          when 'internet explorer'
            Capybara::Selenium::Driver.new(app, browser: :internet_explorer)
          when 'chrome'
            preferences = {
              download: {
                directory_upgrade: true,
                prompt_for_download: false,
                default_directory: "#{Dir.pwd}/downloads"
              },
              plugins: {
                always_open_pdf_externally: true
              },
              args: [ "--start-maximized" ]
            }

            caps = Selenium::WebDriver::Remote::Capabilities.chrome(
              chromeOptions: { prefs: preferences }
            )
            @driver = Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: caps)
          else
            #abort('imporper BROWSER_NAME')
            raise RuntimeError, 'Invalid browser Name'
  		    end
        end
      when 'native-app'

        env_number = ENV['TEST_ENV_NUMBER'].to_i == 0 ? '1' : ENV['TEST_ENV_NUMBER'].to_s
        case ENV['APP_TYPE']
          when 'ios'
            Capybara.configure do |config|
                config.default_driver = :appium
                config.run_server = false

                config.default_max_wait_time = 5
            end
            file_name = File.join('artifacts','config_settings','appium_' + env_number + '.txt')
            caps = Appium.load_appium_txt file: File.expand_path('./',file_name), verbose: true

            url = "http://localhost:4723/wd/hub"
            Capybara.register_driver :appium do |app|
              all_options = caps.merge({appium_lib: {server_url: url}, global_driver: false})
              puts all_options.inspect

              @driver = Appium::Capybara::Driver.new app, all_options
            end
            %x('defaults write com.apple.iphonesimulator ConnectHardwareKeyboard -bool no')
          else
            raise RuntimeError, 'Invalid App type Name provided : ' + ENV['APP_TYPE']
          end
      else
        #abort('imporper BROWSER_NAME')
        raise RuntimeError, 'Invalid Environment Name'
    	end
    end
  end
end
