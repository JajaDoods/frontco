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

    html_form = Frontco.html.form(action: '#', method: 'post') do
        label('Username') { input(type: 'text', required: true) }
        label('Password') { input(type: 'password', required: true) }
        button('Submit')
    end
```
