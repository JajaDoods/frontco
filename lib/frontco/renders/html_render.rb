# frozen_string_literal: true

module Frontco
  module Renders
    # Strategy for HTML rendering
    class HTMLRender < HypertextRender
      attr_reader :output

      def initialize(&block)
        @tags = []
        @output = ''
        @parent_tag = nil

        new(&block)
      end

      def new(&block)
        @tags.clear
        @output = ''

        @block = block
        @block.arity.zero? ? instance_eval(&block) : yield(self)
        self
      end

      def add_tag(tag, *text, **attrs, &subelements)
        tag = Frontco::Elements::HTML.create_element(tag, *text, **attrs, &subelements)

        if tag.is_a?(Frontco::Elements::HTML::HTMLPairedElement) && block_given?
          parent_tag_copy = @parent_tag
          @parent_tag = tag
          subtags.arity.zero? ? instance_eval(&subtags) : yield(self)
          @parent_tag = parent_tag_copy
        end

        @parent_tag.nil? ? @tags << tag : @parent_tag << tag
      end

      def render(**params)
        @output = @tags.map do |tag|
          tag.render(**params)
        end.join
        self
      end

      def to_file(file_path, mode: 'a')
        File.write(file_path, @output, mode: mode)
      end
    end
  end
end
