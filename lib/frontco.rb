# frozen_string_literal: true

require_relative 'frontco/version'

# Main module
module Frontco
  autoload(:Atoms, 'frontco/atoms/atoms.rb')
  autoload(:Renders, 'frontco/renders/renders.rb')
  autoload(:Elements, 'frontco/elements/elements.rb')

  # Context class
  class Render
    def render(**params)
      @render.render(**params)
    end

    def new(&block)
      @render.new(&block)
    end

    def to_file(file_path)
      @render.to_file(file_path)
    end

    def from_file(file_path)
      @render.from_file(file_path)
    end
  end

  # Context for HTMLRender
  class HTML < Render
    include Frontco::Renders

    def initialize(&block)
      @render = HTMLRender.new(&block)
    end
  end
end
