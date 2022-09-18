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

        return wrap_tag("<#{@tag}#{attrs}>") unless @paired
        return wrap_tag("<#{@tag}#{attrs}>#{@text.join(' ')}</#{@tag}>") if @subtags.empty?

        wrap_tag("<#{@tag}#{attrs}>") + render_text + render_subtags + wrap_tag("</#{@tag}>")
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
        output = @text.map { |t| wrap_tag(t) }.join
        @indent -= @step
        output
      end

      def format_attrs
        @attrs.map do |a, v|
          v == true ? a.to_s : "#{a}='#{v}'"
        end.join ' '
      end

      def wrap_tag(str, newline: true)
        (' ' * @indent) + str + ("\n" if newline)
      end
    end
  end
end
