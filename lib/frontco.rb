# frozen_string_literal: true

module Frontco
  require_relative 'frontco/version'
  require_relative 'frontco/tags'

  autoload(:Renders, 'frontco/renders')
  autoload(:HTML, 'frontco/wrappers/html.rb')
end
