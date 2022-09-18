# frozen_string_literal: true

module Frontco
  module Renders
    # Strategy for HTML rendering
    class HTMLRender < HypertextRender
      include Frontco::Elements

      def add_tag(tag, paired, *text, **attrs, &subtags)
        tag = HTMLTag.new(tag, paired, *text, **attrs)

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
        @tags.map do |tag|
          tag.render(**params)
        end.join
      end
    end
  end
end
