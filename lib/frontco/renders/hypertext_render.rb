# frozen_string_literal: true

module Frontco
  module Renders
    # Base abstract class for hypertext renders
    class HypertextRender
      include Frontco::Atoms::HypertextAtoms

      PAIRED_TAGS.each do |tag|
        define_method(tag) do |*text, **attrs, &subtags|
          add_tag(tag, true, *text, **attrs, &subtags)
        end
      end

      SINGLETON_TAGS.each do |tag|
        define_method(tag) do |**attrs|
          add_tag(tag, false, **attrs)
        end
      end

      def initialize(&block)
        @tags = []
        @parent_tag = nil
        new(&block)
      end

      def new(&block)
        @tags.clear
        @block = block
        @block.arity.zero? ? instance_eval(&block) : yield(self)
        self
      end

      def add_tag(tag, paired, *text, **attrs, &subtags)
        raise NotImplementedError
      end

      def render
        raise NotImplementedError
      end

      def to_file
        raise NotImplementedError
      end

      def from_file
        raise NotImplementedError
      end
    end
  end
end
