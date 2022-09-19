# frozen_string_literal: true

module Frontco
  module Elements
    # Represents HTML tag
    class HTMLTag
      def initialize(tag, paired, *text, **attrs)
        @tag = tag
        @paired = paired
        @text = text
        @attrs = attrs
        @subtags = []
      end

      def render(indent: 0, step: 4)
        @indent = indent
        @step = step
        attrs = @attrs.empty? ? '' : " #{format_attrs}"

        return add_indents("<#{@tag}#{attrs}>\n") unless @paired
        return add_indents("<#{@tag}#{attrs}>#{@text.join(' ')}</#{@tag}>\n") if @subtags.empty?

        add_indents("<#{@tag}#{attrs}>\n") + render_text + render_subtags + add_indents("</#{@tag}>\n")
      end

      def <<(tag)
        raise ArgumentError, 'HTML tag contains only HTML tags' unless tag.is_a? HTMLTag

        @subtags << tag
      end

      private

      def render_subtags
        @subtags.map do |tag|
          tag.render(indent: @indent + @step, step: @step)
        end.join
      end

      def render_text
        return '' if @text.empty?

        @indent += @step
        output = @text.map { |txt| add_indents("#{txt}\n") }.join
        @indent -= @step
        output
      end

      def format_attrs
        @attrs.map do |a, v|
          v == true ? a.to_s : "#{a}='#{v}'"
        end.join ' '
      end

      def add_indents(str)
        (' ' * @indent) + str
      end
    end
  end
end
