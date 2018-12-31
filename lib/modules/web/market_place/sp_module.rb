module MARKETPLACE
    class SP
      class << self
        include RSpec::Matchers
        include Capybara::DSL

        def add_new_strategy(username, password)
          @logger = Base.instance.logger
          @logger.info('I have logged in')
          MARKETPLACE::LandingPage.login('sp@weinvest.net','weinvest123')
        end

        def log(i)
          @logger = Base.instance.logger
          @logger.info('Im in module of ' + i.to_s)
        end
      end
    end
end
