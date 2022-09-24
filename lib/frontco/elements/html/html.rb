# frozen_string_literal: true

module Frontco
  module Elements
    # HTML module contains HTML elements
    module HTML
      autoload(:HTMLElement, 'frontco/elements/html/html_element.rb')

      # Autoload all files
      @element_class = {}
      Dir['lib/frontco/elements/html/*.rb'].map { |p| File.basename(p, '.rb') }.each do |f|
        next if %w[html_element html].include? f

        html_element = /html_(.*)_element/.match(f)[1].to_sym
        special_class = f.split('_')[1...-1].inject('') { |r, v| r + v.capitalize }

        @element_class[html_element] = :"HTML#{special_class}Element"
        autoload(@element_class[html_element], "frontco/elements/html/#{f}")
      end

      # Error for unkown HTML tag
      class UnknownHTMLTag < ArgumentError
        def initialize(tag)
          super("Unkown tag #{tag}")
        end
      end

      def self.create_element(tag, *text, **attrs, &subelements)
        include Frontco::Atoms::HypertextAtoms
        include Frontco::Elements

        case tag
        when *@element_class.keys then HTML.const_get(@element_class[tag]).new(tag, *text, **attrs,
                                                                               &subelements)
        when *PAIRED_TAGS then HTMLPairedElement.new(tag, *text, **attrs, &subelements)
        when *SINGLETON_TAGS then HTMLSingletonElement.new(tag, *text, **attrs, &subelements)
        else
          raise UnknownHTMLTag, tag
        end
      end
    end
  end
end
