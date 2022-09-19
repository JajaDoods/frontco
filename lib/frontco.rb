# frozen_string_literal: true

require_relative 'frontco/version'

# Main module
module Frontco
  autoload(:Atoms, 'frontco/atoms/atoms.rb')
  autoload(:Renders, 'frontco/renders/renders.rb')
  autoload(:Elements, 'frontco/elements/elements.rb')

  # Context class
  class Render
    def method_missing(method, *args, **params, &block)
      if @render.respond_to? method
        @render.send(method, *args, **params, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      @render.respond_to?(method) || super
    end
  end

  # Context for HTMLRender
  class HTML < Render
    include Frontco::Renders

    def initialize(&block)
      @render = HTMLRender.new(&block || proc {})
    end
  end
end
