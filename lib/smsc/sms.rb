require 'digest/md5'
require 'faraday'

module Smsc
  class Sms
    def initialize(options = {})
      @options = Smsc.default_options.merge(options)

      @options[:password] = Digest::MD5.hexdigest(@options[:password].to_s)

      @connection = Faraday.new(url: 'https://smsc.ru') do |i|
        i.request  :url_encoded
        i.response :logger
        i.adapter  Faraday.default_adapter
      end
    end

    def message(message, phones)
      @connection.post('/sys/send.php', login: @options[:login],
                       psw: @options[:password],
                       phones: phones.join(','),
                       mes: message,
                       sender: @options[:sender],
                       charset: @options[:charset])
    end
  end
end
