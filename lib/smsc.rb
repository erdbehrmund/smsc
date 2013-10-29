require 'smsc/sms'

module Smsc
  @default_options = {}

  class << self; attr_accessor :default_options; end
end
