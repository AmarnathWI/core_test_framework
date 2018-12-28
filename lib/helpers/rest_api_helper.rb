require "net/http"
require "uri"

module Helper
  class RestApi
      class << self

      def get_attribs(uri,attributes)

        uri = URI.parse(uri)
        uri.query = URI.encode_www_form(attributes['params'])
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        http.use_ssl = true

        if attributes['headers']
          attributes['headers'].each do |key, value|
          request[key] = value
          end
        end

        response = http.request(request)

        response

      end

       def get(uri)

        uri = URI.parse(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        http.use_ssl = true
        response = http.request(request)
        response

      end

      def get_with_params(request_url,params)

        uri = URI.parse(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        headers.each do |key, value|
          request[key] = value
        end
        response

      end


      end

  end
end
