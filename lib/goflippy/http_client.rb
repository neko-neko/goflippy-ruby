require 'uri'
require 'net/http'
require 'json'

module GoFlippy
  class HttpClient
    HTTP_API_KEY_HEADER = 'X-Api-Key'

    def initialize(api_key, opts = {})
      @api_key = api_key
      @api_uri = opts.api_uri
      @open_timeout = opts.open_timeout
      @read_timeout = opts.read_timeout
    end

    def get(path, params = {})
      uri = uri(path, params)

      req = Net::HTTP::Get.new(uri.request_uri)
      req['Accept'] = 'application/json'
      req[GoFlippy::HTTP_API_KEY_HEADER] = 'application/json'
      request(uri, req)
    end

    def post(path, params = {})
      uri = uri(path, params)

      req = Net::HTTP::Post.new(uri.request_uri)
      req['Accept'] = 'application/json'
      req['Content-Type'] = 'application/json'
      req[GoFlippy::HTTP_API_KEY_HEADER] = 'application/json'
      req.body = params.to_json unless params.empty?
      request(uri, req)
    end

    private

    def uri(path, params = {})
      if params.empty?
        URI.parse("#{@api_uri}#{path}")
      else
        encoded_params = URI.encode_www_form(params)
        URI.parse("#{@api_uri}#{path}/?#{encoded_params}")
      end
    end

    def request(uri, req)
      begin
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.open_timeout = @open_timeout
          http.read_timeout = @read_timeout
          http.request(req)
        end
      rescue => e
        # TODO: Implement logger
      end

      case response
      when Net::HTTPSuccess
        json = response.body
        JSON.parse(json, symbolize_names: true)
      when Net::HTTPRedirection
        request(URI.parse(response['location']), req)
      else
        # TODO: Implement logger
      end
    end
  end
end
