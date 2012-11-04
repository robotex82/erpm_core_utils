require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module ERPM
  module CoreUtils
    module Configuration
      def configure
        yield self
      end

      # mattr_accessor :foo
      # @@foo = nil
    end
  end
end
