require 'magiq/param'

module Magiq
  class Builder
    END_RNG     = /\}([a-z0-9_]+)\Z/
    START_RNG   = /\A([a-z0-9_]+)\{/
    CONSTRAINTS = [:mutual, :exclusive]
    LISTENERS   = [:check, :apply]

    attr_reader :listeners, :constraints, :params

    def initialize
      @listeners   = Hash.new { |h, k| h[k] = [] }
      @constraints = []
      @params      = {}
    end

    def add_listener(type, params, opts = {}, &block)
      listeners_for(type) << [type, params, opts, block]
    end

    def listeners_for(type)
      if !LISTENERS.include?(type)
        raise ArgumentError, "unknown listener type: #{type.inspect}"
      end

      listeners[type]
    end

    def add_param(key, opts = {})
      param = Param.new(key, opts)

      param.keys.each do |k|
        if params.key?(k.to_sym)
          raise ArgumentError, "already registered param under key/alias: " \
          "#{k}"
        end

        params[k] = param
      end
    end

    def add_constraint(op, params_arg, opts = {})
      if !CONSTRAINTS.include?(op)
        raise ArgumentError, "unknown constraint type: #{op.inspect}"
      end

      params = Array(params_arg)

      if params.size == 1 && !opts[:exclusive]
        raise ArgumentError, "a single parameter can't be mutual unless it " \
          "has an exclusive counterpart"
      end

      params.each do |p|
        constraints << [op, params, opts]
      end
    end
  end
end
