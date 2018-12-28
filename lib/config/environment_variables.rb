class EnvironmentVariables
  class << self
    require 'singleton'
    def set_env_variables
      read_config_file
      set_variables
      env_constants
    end

    # Read config file from ENV['PROPERTIES']
    def read_config_file
      @configs = Helper::FileReaderHelper.read_yaml_data(FrameworkConstants.environment_settings_yaml_file.to_s)
    end

    # Sets ENV variables if not initialize yet
    def set_variables
      @configs.each do |key,value|
        ENV[key.upcase] = value
      end
      current_time_stamp = Time.now.strftime("%Y_%m_%d_%H_%M_%S")
      ENV['CURRENT_TIME'] = current_time_stamp.to_s
    end

    # Sets ENV variables if not initialize yet
    def env_constants
      env_constants = Hash.new

      env_constants[:test_data_folder_path] = File.join(FrameworkConstants.artifacts_folderpath, 'test_data_'+ ENV['EXECUTION_ENVIRONMENT'])
      env_constants[:output_test_data_folder_path] = File.join(FrameworkConstants.artifacts_folderpath, 'test_data_'+ ENV['EXECUTION_ENVIRONMENT'],'output')
      env_constants[:logger_folder_path] = File.join(env_constants[:test_data_folder_path], 'log', 'logger_file', ENV['CURRENT_TIME'] )
      env_constants[:allure_raw_reports_folder_path] = File.join(FrameworkConstants.artifacts_folderpath, 'test_data_'+ ENV['EXECUTION_ENVIRONMENT'], 'reports', 'allure_raw_reports', ENV['CURRENT_TIME'])
      env_constants[:allure_reports_folder_path] = File.join(FrameworkConstants.artifacts_folderpath, 'test_data_'+ ENV['EXECUTION_ENVIRONMENT'], 'reports', 'allure_reports', ENV['CURRENT_TIME'] )
      env_constants.with_indifferent_access
    end


  end
end
