require 'net/http'
require 'uri'
require 'openssl'

#HTTP
uri = URI.parse("http://www.google.com.tw")
Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new(uri)
  response = http.request(request)
  puts response.code
end

#HTTPS
uri = URI.parse("https://www.google.com.tw")
Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  #http.verify_mode = OpenSSL::SSL::VERIFY_NONE 
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Get.new(uri)
  response = http.request(request)
  puts http.use_ssl?
  puts response.code
end


# HTTP METHODS

class Request
  VERB_MAP = {
    :get    => Net::HTTP::Get,
    :post   => Net::HTTP::Post,
    :put    => Net::HTTP::Put,
    :delete => Net::HTTP::Delete
  }

  def initialize(method, path, params)
    request(method, path, params)
  end
  
  private
  
  def request(method, path, params)
    case method
    when :get
      full_path = encode_path_params(path, params)
      request = VERB_MAP[method].new(full_path)
    else
      request = VERB_MAP[method].new(path)
      request.set_form_data(params)
    end

    request
  end
end
