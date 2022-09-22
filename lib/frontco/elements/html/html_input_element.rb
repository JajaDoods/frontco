# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Specified class for input HTML tag
      class HTMLInputElement < HTMLSingletonElement
        # basic input values
        %i[
          text password checkbox button number color date
          email file hidden image month radio range reset
          search submit tel time url week
        ].each do |type_val|
          define_method(type_val) { type(type_val.to_s) }
        end

        def type(val)
          @attrs[:type] = val
          self
        end

        def required
          @attrs[:required] = true
          self
        end
      end
    end
  end
end
