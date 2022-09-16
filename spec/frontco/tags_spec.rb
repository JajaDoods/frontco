# frozen_string_literal: true

RSpec.describe Frontco::Tags do
  it 'Has a paired tags' do
    expect(Frontco::Tags::PAIRED_TAGS).not_to be_nil
  end

  it 'Has a singleton tags' do
    expect(Frontco::Tags::SINGLETON_TAGS).not_to be_nil
  end
end
