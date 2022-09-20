# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Basic abstract class for HTML tags
      class HTMLElement
        def render(**params)
          raise NotImplementedError
        end

        protected

        def add_indents(str)
          (' ' * @indent) + str
        end

        def format_attrs
          @attrs.map do |attr, val|
            val == true ? attr.to_s : "#{attr}='#{val}'"
          end.join ' '
        end
      end
    end
  end
end
