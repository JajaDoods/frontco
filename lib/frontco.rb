# frozen_string_literal: true

# Main module
module Frontco
  require_relative 'frontco/version'
  require_relative 'frontco/tags'

  autoload(:Renders, 'frontco/renders')

  # Easier access for HTMLRender class
  def self.html(**kwargs)
    Frontco::Renders::HTMLRender.new(**kwargs)
  end

  # Easier access for PugRender class
  def self.pug(**kwargs)
    Frontco::Renders::PugRender.new(**kwargs)
  end
end
