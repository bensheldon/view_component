# frozen_string_literal: true
require "active_job/serializers"

module ViewComponent
  class ActiveJobSerializer < ActiveJob::Serializers::ObjectSerializer
    def serialize?(argument)
      argument.is_a?(ViewComponent::Base) && argument.respond_to?(:serialize)
    end

    def serialize(view_component)
      super(view_component.serialize)
    end

    def deserialize(hash)
      ViewComponent::Base.deserialize(hash)
    end
  end
end
