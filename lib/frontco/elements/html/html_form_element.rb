# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Specified class for input HTML tag
      class HTMLFormElement < HTMLPairedElement
        %i[_blank _top _self _parent].each do |target_value|
          define_method(target_value) { target(target_value.to_s) }
        end

        def get
          @attrs[:method] = 'get'
          self
        end

        def post
          @attrs[:method] = 'post'
        end

        def target(val)
          @attrs[:target] = val
          self
        end
      end
    end
  end
end
