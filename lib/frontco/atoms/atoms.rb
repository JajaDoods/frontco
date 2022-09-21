# frozen_string_literal: true

module Frontco
  # Contains atoms
  module Atoms
    autoload(:HypertextAtoms, 'frontco/atoms/hypertext_atoms.rb')

    HYPERTEXT_ATOMS = (HypertextAtoms::PAIRED_TAGS +
                       HypertextAtoms::SINGLETON_TAGS +
                       HypertextAtoms::SPECIAL_TAGS).freeze
  end
end
