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

    # print ouput html to the console  
    puts html.render(indent: 10, step: 2).output
    
    # or you can save html into a file
    html.save_to_file('file-path.html')

    # or
    html.render
    puts html.output # print to console
    html.save_to_file('file-path.html') # and save into a file
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
            <p>Easy! Just use HTML tags and enjoy!</p>
          </form>
```
