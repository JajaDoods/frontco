# frozen_string_literal: true

# needed monkey putch for 'Checking doctype' test
module Frontco
  module Renders
    class PugRender
      attr_reader :output
    end
  end
end

RSpec.describe Frontco::Renders::PugRender do
  it 'Checking doctype' do
    expect(described_class.new(doctype: true).output).to eq("doctype html\n")
    expect(described_class.new(indent: 2, doctype: true).output).to eq("  doctype html\n")
  end

  it 'Checking tags' do
    pug = described_class.new(indent_step: 2, doctype: true).html(lang: 'en') do
      form(action: '#', method: 'post') do
        label('Username') { input class: 'form__username', type: 'text' }
        label('Password') { input class: 'form__password', type: 'password', required: true, data: false }
        a { img }
        button('Submit')
      end
    end

    pug_ = <<~PUG
      doctype html
      html(lang='en')
        form(action='#', method='post')
          label
            | Username
            input.form__username(type='text')
          label
            | Password
            input.form__password(type='password', required, data='false')
          a
            img
          button Submit
    PUG
    expect(pug).to eq(pug_)
  end

  it 'Checking indents' do
    html = described_class.new(indent: 4, indent_step: 2, doctype: true).html(lang: 'en') do
      form(action: '#', method: 'post') do
        label('Username') { input class: 'form__username', type: 'text' }
        label('Password') { input class: 'form__password', type: 'password', required: true, data: false }
        a { img }
        button('Submit')
      end
    end

    html_ = <<-PUG
    doctype html
    html(lang='en')
      form(action='#', method='post')
        label
          | Username
          input.form__username(type='text')
        label
          | Password
          input.form__password(type='password', required, data='false')
        a
          img
        button Submit
    PUG
    expect(html).to eq(html_)
  end
end
