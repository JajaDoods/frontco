# frozen_string_literal: true

module Frontco
  module Renders
    # Strategy for HTML rendering
    class HTMLRender < HypertextRender
      include Frontco::Elements

      attr_reader :output

      def initialize(&block)
        @tags = []
        @parent_tag = nil
        @output = ''
        new(&block)
      end

      def new(&block)
        @tags.clear
        @output = ''

        @block = block
        @block.arity.zero? ? instance_eval(&block) : yield(self)
        self
      end

      def add_tag(tag, paired, *text, **attrs, &subtags)
        tag = HTMLTag.new(tag, paired, @parent_tag, *text, **attrs)

        unless paired && block_given?
          @parent_tag.is_a?(HTMLTag) ? @parent_tag << tag : @tags << tag
          return
        end

        parent_tag_copy = @parent_tag
        @parent_tag = tag

        subtags.arity.zero? ? instance_eval(&subtags) : yield(self)

        @parent_tag = parent_tag_copy
        @parent_tag.is_a?(HTMLTag) ? @parent_tag << tag : @tags << tag
      end

      def render(**params)
        @output = @tags.map do |tag|
          tag.render(**params)
        end.join
        self
      end

      def save_to_file(file_path, mode: 'a')
        File.write(file_path, @output, mode: mode)
      end
    end
  end
end
