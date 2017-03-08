require 'active_support'

module Magiq
  module Utils
    module_function

    def pluralize(string)
      ActiveSupport::Inflector.pluralize(string)
    end

    def blank?(val)
      val.respond_to?(:empty?) ? !!val.empty? : !val
    end

    def present?(val)
      !blank?(val)
    end
  end
end
