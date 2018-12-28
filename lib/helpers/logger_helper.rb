require 'logger'
module Helper

  class LoggerHelper

    def logger
      @logger
    end

    def get_logger
      current_rspec = RSpec.current_example.metadata[:file_path].to_s.split('/').last.split('.').first.to_s
      current_logger_file = File.join( EnvironmentVariables.env_constants[:logger_folder_path] , current_rspec  + '.log')

      #to create file directory if not present
      puts EnvironmentVariables.env_constants[:test_data_folder_path]
      puts File.directory?(EnvironmentVariables.env_constants[:test_data_folder_path])
      if File.directory?(EnvironmentVariables.env_constants[:test_data_folder_path])
        unless File.directory?(EnvironmentVariables.env_constants[:logger_folder_path] )
          FileUtils.mkdir_p(EnvironmentVariables.env_constants[:logger_folder_path] )
        end
      else
        #abort('imporper BROWSER_NAME')
        raise RuntimeError, 'Invalid Execution Environment Name'
      end

      #creating a new log file for each spec
      File.new(current_logger_file, 'w')
      file = File.open(current_logger_file, File::WRONLY | File::APPEND)

      #to log both in console and file
      @logger = Logger.new MultiDelegator.delegate(:write, :close).to(STDOUT, file)
      @logger.level = Logger::DEBUG

      #formatting the logger output
      @logger.formatter = proc do |severity, datetime, progname, msg|
        callee = caller[3]                         # get caller from stack
        callee = callee.split('/').last            # remove path from callee info
        callee = callee.split(':')[0, 2].join(':') # remove method name from info
        spec_name = '%-30.30s' % current_rspec
        " #{severity} [#{datetime.strftime('%Y-%m-%d %H:%M:%S.%6N')} ##{Process.pid}] [#{spec_name}][#{callee}]: #{msg}\n"
      end

      @logger
    end

    class MultiDelegator
      def initialize(*targets)
        @targets = targets
      end

      def self.delegate(*methods)
        methods.each do |m|
          define_method(m) do |*args|
            @targets.map { |t| t.send(m, *args) }
          end
        end
        self
      end

      class <<self
        alias to new
      end
    end
  end
end
