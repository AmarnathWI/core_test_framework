class FrameworkConstants
   @output_download_folderpath = File.join('.', 'artifacts', 'test_data', 'output','downloads')
   @environment_settings_yaml_file = File.join('.', 'artifacts', 'config_settings', 'env_settings.yaml')
   @artifacts_folderpath = File.join('.', 'artifacts')
   @global_test_data_yaml_filename = "global_test_data.yaml"

  class << self
    attr_accessor :output_download_folderpath,
                  :environment_settings_yaml_file,
                  :artifacts_folderpath,
                  :global_test_data_yaml_filename
  end
end
