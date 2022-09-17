# frozen_string_literal: true

module Frontco
  module Renders
    # Render ruby block into HTML source code
    class HTMLRender < HypertextRender
      # Used for adding the text into subtags
      #
      # ==== Attributes
      # * +text+ text that need add into subtags
      def rtext(text)
        @output += format_if_pretty(text.to_s)
      end

      protected

      # Creates a paired HTML tag
      # For more details see Frontco::Renders::BaseRender#create_paired_tag
      def create_paired_tag(tag, text, **attrs, &subtags)
        attrs_ = attrs.empty? ? '' : " #{format_attrs(**attrs)}"
        if block_given?
          @output += format_if_pretty("<#{tag}#{attrs_}>")

          render_subtags(text, &subtags)

          @output += format_if_pretty("</#{tag}>")
        else
          @output += format_if_pretty("<#{tag}#{attrs_}>#{text}</#{tag}>")
        end
      end

      # Creates a singleton HTML tag
      # For more details see Frontco::Renders::BaseRender#create_singleton_tag
      def create_singleton_tag(tag, **attrs)
        attrs_ = attrs.empty? ? '' : " #{format_attrs(**attrs)}"
        @output += format_if_pretty("<#{tag}#{attrs_}>")
      end

      # Creates a HTML doctype
      # For more details see Frontco::Renders::BaseRender#create_doctype
      def create_doctype
        format_if_pretty('<!DOCTYPE html>')
      end

      # Rendering tags with indentation
      def render_subtags(text, &tags)
        @indent += @indent_step

        rtext(text) unless text.empty?
        tags.arity.zero? ? instance_eval(&tags) : yield(self)

        @indent -= @indent_step
      end

      # Formatting string if @pretty if true
      def format_if_pretty(str, newline: true)
        @pretty ? add_indent(str, newline: newline) : str
      end
    end
  end
end
