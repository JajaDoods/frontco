# Frontco

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'frontco'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install frontco

## Examples

```ruby
    require 'frontco'

    html = Frontco::HTML.new do
      h2('How i can create a form?')
      form(action: '#', method: 'post') do
        label('Username.') { input(type: 'text', required: true) }
        label('Password.', 'Please, enter the valid data!!') { input(type: 'password', required: true) }
        button('Submit!')
      end
      p('Easy!', 'Just use HTML tags and enjoy!')
    end
    html.render(indent: 2, step: 2)
```
Result HTML
```html
      <h2>How i can create a form?</h2>
      <form action='#' method='post'>
        <label>
          Username.
          <input type='text' required>
        </label>
        <label>
          Password.
          Please, enter the valid data!!
          <input type='password' required>
        </label>
        <button>Submit!</button>
      </form>
      <p>Easy! Just use HTML tags and enjoy!</p>
```