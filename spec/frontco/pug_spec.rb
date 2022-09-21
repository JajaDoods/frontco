# frozen_string_literal: true

RSpec.describe Frontco::Pug do
  it 'Checking Pug render' do
    pug = described_class.new do
      h2('How i can create a form?')
      form(action: '#', method: 'post') do
        label('Username') { input(type: 'text', required: true) }
        label('Password', 'Please, enter the valid data!!') { input(type: 'password', required: true) }
        button('Submit!')
      end
      p('Easy!', 'Just use Pug tags and enjoy!')
    end

    pug_ = <<~PUG
      h2 How i can create a form?
      form(action='#', method='post')
        label
          | Username
          input(type='text', required)
        label
          | Password
          | Please, enter the valid data!!
          input(type='password', required)
        button Submit!
      p
        | Easy!
        | Just use Pug tags and enjoy!
    PUG
    expect(pug.render(step: 2).output).to eq(pug_)

    pug.new do
      div(class: 'wrapper') do
        h1('Lorem ipsum dolor')
        a('Image', href: 'google.com', target: '_blank') { img(src: 'image-location.jpg', alt: 'Image') }
      end
    end
    pug_ = <<-PUG
      div.wrapper
          h1 Lorem ipsum dolor
          a(href='google.com', target='_blank')
              | Image
              img(src='image-location.jpg', alt='Image')
    PUG
    expect(pug.render(indent: 6).output).to eq(pug_)

    pug.new do
      input { a }
    end
    pug_ = <<~PUG
      input
    PUG
    expect(pug.render(step: 2).output).to eq(pug_)
  end
end
