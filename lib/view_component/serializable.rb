# frozen_string_literal: true

require "active_support/concern"

module ViewComponent
  module Serializable
    extend ActiveSupport::Concern

    included do
      __ignored_parameter_ancestors << Interceptor
    end

    class_methods do
      def inherited(child)
        super
        child.prepend Interceptor
      end

      def deserialize(hash)
        hash["class"].constantize.new(hash["initialize"])
      end
    end

    module Interceptor
      def initialize(*args, **kwargs, &)
        super
        @serialized_properties = {
          "initialize" => [*args, Hash.ruby2_keywords_hash(kwargs)]
        }
      end

      def serialize
        @serialized_properties.merge("class" => self.class)
      end
    end
  end
end
