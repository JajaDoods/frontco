# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Class that represents the doctype HTML tag
      class HTMLDoctypeElement < HTMLElement
        def render(**params)
          @indent = params.fetch(:indent, 0)
          add_indents("<!DOCTYPE html>\n")
        end
      end
    end
  end
end
