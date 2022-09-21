# frozen_string_literal: true

module Frontco
  module Elements
    module Pug
      # Base abstract class for hypertext renders
      class PugElement
        def initialize(tag, *text, **attrs, &subelements); end

        def render(**params)
          raise NotImplementedError
        end

        protected

        def add_indents(str)
          (' ' * @indent) + str
        end

        def format_attrs
          class_ = @attrs.key?(:class) ? ".#{@attrs.delete(:class)}" : ''
          id = @attrs.key?(:id) ? "##{@attrs.delete(:id)}" : ''
          attrs = if @attrs.empty? then ''
                  else
                    @attrs.map do |attr, val|
                      val == true ? attr.to_s : "#{attr}='#{val}'"
                    end.join ', '
                  end
          attrs = "(#{attrs})" unless attrs.empty?
          "#{id}#{class_}#{attrs}"
        end
      end
    end
  end
end
