require 'capybara'
require 'capybara/dsl'
require 'yaml'
require 'csv'
require 'rspec'
require 'capybara/rspec/matchers'
require 'selenium-webdriver'
require 'pry'
require 'allure-rspec'
require 'parallel-rspec'
require 'parallel_tests'
require 'byebug'
require 'fileutils'
require 'appium_lib'
require 'roo'
require 'active_support/core_ext/hash/indifferent_access'
require 'airborne'
require 'json'
require "net/http"
require 'tempfile'



Dir['./lib/config/*.rb'].sort.each { |file| require file }
Dir['./lib/helpers/*.rb'].sort.each { |file| require file }
Dir['./lib/pages/MARKET_PLACE/*.rb'].sort.each { |file| require file }
Dir['./lib/pages/IOS/*.rb'].sort.each { |file| require file }
# Set Env variables
EnvironmentVariables.set_env_variables

#Knapsack::Adapters::RspecAdapter.bind


RSpec.configure do |c|
  c.include AllureRSpec::Adaptor
end

AllureRSpec.configure do |c|
  c.output_dir = EnvironmentVariables.env_constants[:allure_raw_reports_folder_path].to_s
  c.clean_dir = false
  c.logging_level = Logger::WARN
end



# ParallelTests.first_process? ? FileUtils.rm_rf(AllureRSpec::Config.output_dir) : sleep(1)
# preparation:
# affected by race-condition: first process may boot slower than the second
# either sleep a bit or use a lock for example File.lock
ParallelTests.first_process? ? FileUtils.rm_rf(AllureRSpec::Config.output_dir) : sleep(1)

# cleanup:
# last_process? does NOT mean last finished process, just last started
ParallelTests.last_process? ? "do_something" : sleep(1)

at_exit do
  if ParallelTests.first_process?
    ParallelTests.wait_for_other_processes_to_finish
  end
end


 RSpec::Parallel.configure do |config|
   config.concurrency = 4
 end

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers, type: :request
  config.include Capybara::RSpecMatchers, type: :acceptance
  config.include RSpec::Matchers
  config.include Capybara::DSL
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  # config.include FileUpload, type: :feature
  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:all) do
    puts @driver
  end

  config.before(:each) do
   WebDriverManager.initialize_driver
   @logger  = Helper::LoggerHelper.new.get_logger
   Base.instance.set_logger(@logger)
   Base.instance.add_runtime_data('test_data',Helper::TestDataHelper.read_test_data)
  end

  config.after(:all) do |example|
   Capybara.current_session.driver.quit
   #command 'allure generate #{EnvironmentVariables.env_constants[:allure_raw_reports_folder_path]} -o #{EnvironmentVariables.env_constants[:allure_reports_folder_path]}'
  # system("allure generate #{EnvironmentVariables.env_constants[:allure_raw_reports_folder_path]} -o #{EnvironmentVariables.env_constants[:allure_reports_folder_path]}")
  # system("allure serve #{EnvironmentVariables.env_constants[:allure_raw_reports_folder_path]}")
  end

  config.after(:each) do |example|
    if example.exception
      ScreenshotHelper.save_screenshot
      page.reset_session!
    end
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
