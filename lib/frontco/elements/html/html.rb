# frozen_string_literal: true

module Frontco
  module Elements
    # HTML module contains HTML elements
    module HTML
      autoload(:HTMLElement, 'frontco/elements/html/html_element.rb')
      autoload(:HTMLDoctypeElement, 'frontco/elements/html/html_doctype_element.rb')
      autoload(:HTMLPairedElement, 'frontco/elements/html/html_paired_element.rb')
      autoload(:HTMLSingletonElement, 'frontco/elements/html/html_singleton_element.rb')

      # Error for unkown HTML tag
      class UnknownHTMLTag < ArgumentError
        def initialize(tag)
          super("Unkown tag #{tag}")
        end
      end

      def self.create_element(tag, *text, **attrs, &subelements)
        include Frontco::Atoms::HypertextAtoms

        case tag
        when :doctype then HTMLDoctypeElement.new(tag, *text, **attrs, &subelements)
        when *PAIRED_TAGS then HTMLPairedElement.new(tag, *text, **attrs, &subelements)
        when *SINGLETON_TAGS then HTMLSingletonElement.new(tag, *text, **attrs, &subelements)
        else
          raise UnknownHTMLTag, tag
        end
      end
    end
  end
end
