# frozen_string_literal: true

module Frontco
  module Renders
    # Base abstract class for HTML, Pug and others render classes
    class HypertextRender
      # creating paired tags
      Frontco::Tags::PAIRED_TAGS.each do |tag|
        define_method(tag) do |text = '', **attrs, &subtags|
          create_paired_tag(tag, text, **attrs, &subtags)
        end
      end

      # creating singleton tags
      Frontco::Tags::SINGLETON_TAGS.each do |tag|
        define_method(tag) do |**attrs|
          create_singleton_tag(tag, **attrs)
        end
      end

      # Create new base render
      #
      # Due the fact that BaseRender is an abstract class then creating a new instance
      # of this class have no sense.
      #
      # This class is used for creating new renders(such as HTMLRender). Only you needed is a
      # inherit this class and implement these methods:
      # * create_paired_tag
      # * create_singleton_tag
      # * create_doctype
      #
      # ==== Attributes
      #
      # * +indent:+ - start indent for code
      # * +indent_step:+ - indent incrementation for subtags
      # * +pretty:+ - pretty output
      # * +doctype:+ - include doctype or not
      def initialize(indent: 0, indent_step: 4, pretty: true, doctype: false)
        @indent = indent
        @indent_step = indent_step
        @pretty = pretty
        @output = (doctype ? create_doctype : '')
      end

      # Used for adding the text into subtags
      #
      # ==== Attributes
      # * +text+ text that need add into subtags
      def rtext(text)
        @output += format_if_pretty(text.to_s)
      end

      protected

      # Create paired tag
      # ==== Attributes
      # * +tag+ tag name(a, li, div for example)
      # * +text+ text that passed into the tag
      # * +attrs+ attributes that added for the tag
      # * +subtags+ tags that contains +tag+
      def create_paired_tag(tag, text, **attrs, &subtags)
        raise NotImplementedError,
              "You need implement create_paired_tag(#{tag}, #{text}, **#{attrs}, &#{subtags})"
      end

      # Create singleton tag
      # ==== Attributes
      # * +tag+ tag name(br, img for example)
      # * +attrs+ attributes that added for the tag
      def create_singleton_tag(tag, **attrs)
        raise NotImplementedError,
              "You need implement create_singleton_tag(#{tag}, **#{attrs})"
      end

      # Create doctype
      def create_doctype
        raise NotImplementedError
      end

      # Supportive method
      #
      # Add indents for string and newline if +newline: true+
      # ==== Attributes
      # * +str+ source string
      # * +newline:+ add new line or not(default true)
      def add_indent(str, newline: true)
        (' ' * @indent) + str + ("\n" if newline)
      end

      # Supportive method
      #
      # Convert attributes from a hash to a string
      # and formatting them
      #
      # ==== Attributes
      # * +attr_join+ join string
      # * +attrs+ attributes thats will be converted to a string
      #
      # ==== Formatting
      # If value of the attribute is a +true+ value, then
      # ouput will be a.to_s. Else, output will be "attribute='value'"
      def format_attrs(attr_join = ' ', **attrs)
        attrs.map { |a, v| v == true ? a.to_s : "#{a}='#{v}'" }.join(attr_join)
      end
    end
  end
end
