module Helper
  class TestDataHelper
    class << self
      def read_test_data
        test_data = Hash.new
        test_data_file = RSpec.current_example.metadata[:file_path]
                        .gsub("./spec",File.join(EnvironmentVariables.env_constants[:test_data_folder_path],"input","spec_test_data"))
                        .gsub(".rb","")

        case ENV['TESTDATA_TYPE'].to_s.downcase
        when 'json'
          json_data = FileReaderHelper.read_json_data(test_data_file + "_td.json")
          if json_data.instance_of? Array
            test_data = json_data
          else
            raise RuntimeError, 'Test data should be provided as an array'
          end
        when 'yaml'
          test_data = FileReaderHelper.read_yaml_data(test_data_file + "_td.yaml")
        end
        test_data
      end
    end
  end
end
