# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Specified class for input HTML tag
      class HTMLAElement < HTMLPairedElement
        def target(val)
          @attrs[:target] = val
          self
        end

        def href(val)
          @attrs[:href] = val
          self
        end
      end
    end
  end
end
