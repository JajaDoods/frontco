# frozen_string_literal: true

RSpec.describe Frontco::HTML do
  it 'Checking HTML render' do
    html = described_class.new do
      h2('How i can create a form?')
      form(action: '#', method: 'post') do
        label('Username') { input(type: 'text', required: true) }
        label('Password', 'Please, enter the valid data!!') { input(type: 'password', required: true) }
        button('Submit!')
      end
      p('Easy!', 'Just use HTML tags and enjoy!')
    end

    html_ = <<~HTML
      <h2>How i can create a form?</h2>
      <form action='#' method='post'>
        <label>
          Username
          <input type='text' required>
        </label>
        <label>
          Password
          Please, enter the valid data!!
          <input type='password' required>
        </label>
        <button>Submit!</button>
      </form>
      <p>
        Easy!
        Just use HTML tags and enjoy!
      </p>
    HTML
    expect(html.render(step: 2).output).to eq(html_)

    html.new do
      div(class: 'wrapper') do
        h1('Lorem ipsum dolor')
        a('Image', href: 'google.com', target: '_blank') { img(src: 'image-location.jpg', alt: 'Image') }
      end
    end
    html_ = <<-HTML
      <div class='wrapper'>
          <h1>Lorem ipsum dolor</h1>
          <a href='google.com' target='_blank'>
              Image
              <img src='image-location.jpg' alt='Image'>
          </a>
      </div>
    HTML
    expect(html.render(indent: 6).output).to eq(html_)

    html.new do
      input { a }
    end
    html_ = <<~HTML
      <input>
    HTML
    expect(html.render(step: 2).output).to eq(html_)
  end
end
