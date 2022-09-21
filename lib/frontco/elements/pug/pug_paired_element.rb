# frozen_string_literal: true

module Frontco
  module Elements
    module Pug
      # Class that represents paired Pug tag
      class PugPairedElement < PugElement
        def initialize(tag, *text, **attrs, &_subelements)
          @tag = tag
          @text = text
          @attrs = attrs

          @subtags = []
        end

        def render(**params)
          @indent = params.fetch(:indent, 0)
          @step = params.fetch(:step, 4)
          tag = add_indents("#{@tag}#{format_attrs}\n")

          return "#{tag.chomp} #{@text.join}\n" if @subtags.empty? && @text.size <= 1

          tag + render_text + render_subtags
        end

        def <<(tag)
          raise ArgumentError, 'Pug tag can contains only Pug tags' unless tag.is_a? PugElement
          raise ArgumentError, "DOCTYPE can't contains in another Pug tag" if tag.is_a? PugDoctypeElement

          @subtags << tag
        end

        protected

        def render_text
          @indent += @step
          output = @text.map do |txt|
            add_indents("| #{txt}\n")
          end.join
          @indent -= @step
          output
        end

        def render_subtags
          return '' if @subtags.empty?

          @subtags.map do |tag|
            tag.render(indent: @indent + @step, step: @step)
          end.join
        end
      end
    end
  end
end
