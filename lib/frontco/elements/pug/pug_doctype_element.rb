# frozen_string_literal: true

module Frontco
  module Elements
    module Pug
      # Class that represents the doctype Pug tag
      class PugDoctypeElement < PugElement
        def render(**params)
          @indent = params.fetch(:indent, 0)
          add_indents("doctype html\n")
        end
      end
    end
  end
end
