# frozen_string_literal: true

module Frontco
  module Renders
    # Base abstract class for HTML, Pug and others render classes
    class BaseRender
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

      protected

      def create_paired_tag(tag, text, **attrs, &subtags)
        raise NotImplemenentedError,
              "You need implement create_paired_tag(#{tag}, #{text}, **#{attrs}, &#{subtags})"
      end

      def create_singleton_tag(tag, **attrs)
        raise NotImplemenentedError,
              "You need implement create_singleton_tag(#{tag}, **#{attrs})"
      end
    end
  end
end
