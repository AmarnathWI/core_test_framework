module MARKETPLACE
    class LandingPage



        # def initialize(**args)
        #   #@logger = args[:logger]
        #   @logger = Base.instance.logger
        #   @login_link = "//a[text()='Login']"
        #   @user_email = "//input[@id='email']"
        #   @user_password = "//input[@id='password']"
        #   @login_button = "//button[text()='Login']"

        # end

      @login_link = "//a[text()='Login']"
      @user_email = "//input[@id='email']"
      @user_password = "//input[@id='password']"
      @login_button = "//button[text()='Login']"
      class << self
        include RSpec::Matchers
        include Capybara::DSL

        def login(username, password)
          @logger = Base.instance.logger
          puts @logger
          @logger.info('I am ready to login')
          find(:xpath,@login_link).click
          find(:xpath,@user_email).set username
          find(:xpath,@user_password).set password
          find(:xpath,@login_button).click
          @logger.info('I have logged in')
        end

        def log(i)
          @logger = Base.instance.logger
          @logger.info('I have logged in ' + i.to_s)
        end

      end

    end
end
