module Helper
  class FileReaderHelper
    class << self
      def read_config_data(filename)
        test_data = []
        file_settings = { encoding: 'UTF-8', headers: true }
        CSV.foreach(filename, file_settings) do |row|
          test_data << row.to_hash
        end
        test_data
      end

      def read_yaml_data(file)
        if File.exist?(file)
          return YAML.load_file(file)
        else
          #abort('imporper BROWSER_NAME')
          raise RuntimeError, 'Invalid file path : ' + file.to_s
        end
      end

      def read_json_data(file)
        if File.exist?(file)
          return JSON.parse(File.read(file))
        else
          #abort('imporper BROWSER_NAME')
          raise RuntimeError, 'Invalid file path : ' + file.to_s
        end
      end
    end
  end
end
