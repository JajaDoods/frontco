# frozen_string_literal: true

module Frontco
  module Elements
    module Pug
      # Class that represents singleton Pug tag
      class PugSingletonElement < PugElement
        def initialize(tag, *_text, **attrs, &_subelements)
          @tag = tag
          @attrs = attrs
        end

        def render(**params)
          @indent = params.fetch(:indent, 0)
          add_indents("#{@tag}#{format_attrs}\n")
        end
      end
    end
  end
end
