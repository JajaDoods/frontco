# frozen_string_literal: true

RSpec.describe Frontco::Renders::BaseRender do
  render = described_class.new

  it 'Has all paired tags' do
    Frontco::Tags::PAIRED_TAGS.each do |tag|
      expect(render.respond_to?(tag)).to be(true)
    end
  end

  it 'Has all singleton tags' do
    Frontco::Tags::SINGLETON_TAGS.each do |tag|
      expect(render.respond_to?(tag)).to be(true)
    end
  end
end
