require 'singleton'

class Base
  include Singleton

  attr_accessor :rtd_hash

  def initialize
    pp "iam in"
    @rtd_hash = Hash.new
  end

  def set_logger(logger_inst)
    @logger = logger_inst
  end

  def logger
    @logger
  end

  def message_file(message,type='txt')
     thread = ENV['TEST_ENV_NUMBER'] || 0
    temp_file_name = EnvironmentVariables.env_constants[:output_test_data_folder_path] + '/tmp/' + thread.to_s + '_message.' + type
    File.delete(temp_file_name) if File.exist?(temp_file_name)
    file = File.open(temp_file_name, 'w+')
    case type.downcase
    when 'json'
      file.write(JSON.pretty_generate(message))
    else
      file.write(message)
    end
    file.close
    file
  end

  def add_runtime_data(key,value)
    @rtd_hash.merge!(Hash[key,value])
  end

  def runtime_data
    @rtd_hash.with_indifferent_access
  end
end
