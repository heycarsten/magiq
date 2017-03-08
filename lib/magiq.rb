require 'ostruct'
require 'magiq/version'

module Magiq
  class Error < StandardError; end
  class ParamsError < Error; end
  class BadParamError < Error; end

  DEFAULT_CONFIG = OpenStruct.new(
    array_param_limit: 150,
    default_page_size: 50,
    max_page_size:     250,
    min_page_size:     1
  )

  module_function

  def [](key)
    config[key]
  end

  def config
    @config ||= DEFAULT_CONFIG.dup
  end

  def configure
    yield(config)
  end
end

require 'magiq/query'
