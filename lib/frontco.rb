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
      @render.send(method, *args, **params, &block) 
    end
  end

  # Context for HTMLRender
  class HTML < Render
    include Frontco::Renders

    def initialize(&block)
      @render = HTMLRender.new(&block || Proc.new {})
    end
  end
end
