# frozen_string_literal: true

# needed monkey putch for 'Checking doctype' test
module Frontco
  module Renders
    class HTMLRender
      attr_reader :output
    end
  end
end

RSpec.describe Frontco::Renders::HTMLRender do
  it 'Checking doctype' do
    expect(described_class.new(doctype: true, pretty: false).output).to eq('<!DOCTYPE html>')
    expect(described_class.new(doctype: true).output).to eq("<!DOCTYPE html>\n")
    expect(described_class.new(indent: 2, doctype: true).output).to eq("  <!DOCTYPE html>\n")
  end

  it 'Checking tags' do
    html = described_class.new(indent_step: 2, doctype: true).html(lang: 'en') do
      form(action: '#', method: 'post') do
        label('Username') { input class: 'form__username', type: 'text' }
        label('Password') { input class: 'form__password', type: 'password', required: true, data: false }
        a { img }
        button('Submit')
      end
    end

    html_ = <<~HTML
      <!DOCTYPE html>
      <html lang='en'>
        <form action='#' method='post'>
          <label>
            Username
            <input class='form__username' type='text'>
          </label>
          <label>
            Password
            <input class='form__password' type='password' required data='false'>
          </label>
          <a>
            <img>
          </a>
          <button>Submit</button>
        </form>
      </html>
    HTML
    expect(html).to eq(html_)
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

    html_ = <<-HTML
    <!DOCTYPE html>
    <html lang='en'>
      <form action='#' method='post'>
        <label>
          Username
          <input class='form__username' type='text'>
        </label>
        <label>
          Password
          <input class='form__password' type='password' required data='false'>
        </label>
        <a>
          <img>
        </a>
        <button>Submit</button>
      </form>
    </html>
    HTML
    expect(html).to eq(html_)
  end

  it 'Checking pretty' do
    html = described_class.new(indent: 4, indent_step: 4, doctype: true, pretty: false).html(lang: 'en') do
      form(action: '#', method: 'post') do
        label('Username') { input class: 'form__username', type: 'text' }
        label('Password') { input class: 'form__password', type: 'password', required: true, data: false }
        a { img }
        button('Submit')
      end
    end

    html_ = <<-HTML
    <!DOCTYPE html>
    <html lang='en'>
        <form action='#' method='post'>
            <label>
                Username
                <input class='form__username' type='text'>
            </label>
            <label>
                Password
                <input class='form__password' type='password' required data='false'>
            </label>
            <a>
                <img>
            </a>
            <button>Submit</button>
        </form>
    </html>
    HTML
    expect(html).to eq html_.gsub(/(>\s+|\s+<)/, &:strip)
  end
end
