# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Class that represents singleton HTML tag
      class HTMLSingletonElement < HTMLElement
        def initialize(tag, *_text, **attrs)
          @tag = tag
          @attrs = attrs
        end

        def render(**params)
          @indent = params.fetch(:indent, 0)

          formatted_attrs = @attrs.empty? ? '' : " #{format_attrs}"
          add_indents("<#{@tag}#{formatted_attrs}>\n")
        end
      end
    end
  end
end
