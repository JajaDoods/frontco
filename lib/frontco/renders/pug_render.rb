# frozen_string_literal: true

module Frontco
  module Renders
    # Render ruby block into Pug source code
    class PugRender < HypertextRender
      def rtext(text)
        @output += add_indent("| #{text}")
      end

      protected

      def create_paired_tag(tag, text, **attrs, &subtags)
        tag = '.' if tag == :div

        class_, id_, attrs_ = extract_attrs(**attrs)

        if block_given?
          @output += add_indent("#{tag}#{id_}#{class_}#{attrs_}")
          render_subtags(text, &subtags)
        else
          @output += add_indent("#{tag}#{id_}#{class_}#{attrs_} #{text}")
        end
      end

      def create_singleton_tag(tag, **attrs)
        class_, id_, attrs_ = extract_attrs(**attrs)

        @output += add_indent("#{tag}#{id_}#{class_}#{attrs_}")
      end

      def create_doctype
        add_indent('doctype html')
      end

      def render_subtags(text, &tags)
        @indent += @indent_step

        rtext(text) unless text.empty?
        tags.arity.zero? ? instance_eval(&tags) : yield(self)

        @indent -= @indent_step
        @output
      end

      def extract_attrs(**attrs)
        class_ = attrs.key?(:class) ? ".#{attrs.delete(:class)}" : ''
        id_    = attrs.key?(:id) ? "##{attrs.delete(:id)}" : ''
        attrs_ = attrs.empty? ? '' : "(#{format_attrs(', ', **attrs)})"

        [class_, id_, attrs_]
      end
    end
  end
end
