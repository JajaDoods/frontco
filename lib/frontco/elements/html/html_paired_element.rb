# frozen_string_literal: true

module Frontco
  module Elements
    module HTML
      # Class that represents paired HTML tag
      class HTMLPairedElement < HTMLElement
        def initialize(tag, *text, **attrs)
          @tag = tag
          @text = text
          @attrs = attrs

          @subtags = []
        end

        def render(**params)
          @indent = params.fetch(:indent, 0)
          @step = params.fetch(:step, 4)

          formatted_attrs = @attrs.empty? ? '' : " #{format_attrs}"
          if @subtags.empty? && @text.size <= 1
            return add_indents("<#{@tag}#{formatted_attrs}>#{@text.join}</#{@tag}>\n")
          end

          add_indents("<#{@tag}#{formatted_attrs}>\n") + render_text + render_subtags + add_indents("</#{@tag}>\n")
        end

        def <<(tag)
          raise ArgumentError, 'HTML tag can contains only HTML tags' unless tag.is_a? HTMLElement
          raise ArgumentError, "DOCTYPE can't contains in another HTML tag" if tag.is_a? HTMLDoctypeElement

          @subtags << tag
        end

        protected

        def render_text
          @indent += @step
          output = @text.map do |txt|
            add_indents("#{txt}\n")
          end.join
          @indent -= @step
          output
        end

        def render_subtags
          @subtags.map do |tag|
            tag.render(indent: @indent + @step, step: @step)
          end.join
        end
      end
    end
  end
end
