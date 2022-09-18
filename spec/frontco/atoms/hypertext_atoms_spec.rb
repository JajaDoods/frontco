# frozen_string_literal: true

RSpec.describe Frontco::Atoms::HypertextAtoms do
  it 'Has a hypertext paired tags' do
    expect(Frontco::Atoms::HypertextAtoms::PAIRED_TAGS).not_to be_nil
  end

  it 'Has a hypertextsingleton tags' do
    expect(Frontco::Atoms::HypertextAtoms::SINGLETON_TAGS).not_to be_nil
  end
end
