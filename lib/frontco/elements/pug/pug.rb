# frozen_string_literal: true

module Frontco
  module Elements
    # Pug module contains Pug elements
    module Pug
      autoload(:PugElement, 'frontco/elements/pug/pug_element.rb')
      autoload(:PugPairedElement, 'frontco/elements/pug/pug_paired_element.rb')
      autoload(:PugSingletonElement, 'frontco/elements/pug/pug_singleton_element.rb')
      autoload(:PugDoctypeElement, 'frontco/elements/pug/pug_doctype_element.rb')

      # Error for unkown Pug tag
      class UnknownPugTag < ArgumentError
        def initialize(tag)
          super("Unkown tag #{tag}")
        end
      end

      def self.create_element(tag, *text, **attrs, &subelements)
        include Frontco::Atoms::HypertextAtoms

        case tag
        when :doctype then PugDoctypeElement.new(tag, *text, **attrs, &subelements)
        when *PAIRED_TAGS then PugPairedElement.new(tag, *text, **attrs, &subelements)
        when *SINGLETON_TAGS then PugSingletonElement.new(tag, *text, **attrs, &subelements)
        else
          raise UnknownPugTag, tag
        end
      end
    end
  end
end
