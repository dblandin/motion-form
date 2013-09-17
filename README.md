# motion-form

RubyMotion forms made easy.

motion-form is heavily inspired by the gem simple_form for Rails.

It aims to bring a simple, yet flexible DSL to the tedious task of creating iOS forms.

[![Gem Version](https://badge.fury.io/rb/motion-form.png)](http://badge.fury.io/rb/motion-form)
[![Code Climate](https://codeclimate.com/github/dblandin/motion-form.png)](https://codeclimate.com/github/dblandin/motion-form)
[![Build Status](https://travis-ci.org/dblandin/motion-form.png?branch=master)](https://travis-ci.org/dblandin/motion-form)

motion-form's initial development was sponsored by [dscout](https://dscout.com). Many thanks to them!

![Screenshot](https://github.com/dblandin/motion-form/blob/master/img/screenshot.png?raw=true)

## Usage

``` ruby
form = MotionForm.form_for(view) do |form|
  # If you don't want section header views, leave the section name blank
  # Ex: form.section do |section|

  form.section 'Profile' do |section|
    section.input :name,      icon: :contact, value: 'David Copperfield'
    section.input :username,  icon: :user
    section.input :pinterest, icon: :pinterest
    section.input :twitter,   icon: :twitter
    section.input :website,   icon: :website
    section.input :bio,       icon: :info
  end

  form.section 'Account' do |section|
    section.button :change_email, icon: :email, action: push_email_controller
    section.button :change_password, icon: :lock, action: push_password_controller
  end
end

def push_email_controller
  lambda do
    # push controller
  end
end

def push_password_controller
  lambda do
    # push controller
  end
end
```

### Validation

You can add validation rules to input fields.

The following syntax is supported:

``` ruby
awesomeness_validator = lambda do |value|
  # validate awesomeness
end

MotionForm.form_for(view) do |form|
  form.section do |section
    section.input :name,        required: true  # present and not blank
    section.input :email,       email: true     # valid email address
    section.input :website,     url: true       # valid url
    section.input :age,         format: /^\d+$/ # matches regex
    section.input :awesomeness, validate_with: awesomeness_validator # custom validator
  end
end
```

### Configuration

``` ruby
MotionForm.config do |config|
  config.icon_font                 = UIFont.fontWithName('dscovr', size: 14.0)
  config.section_header_color      = UIColor.blueColor
  config.section_header_text_color = UIColor.whiteColor
  config.button_text_color         = UIColor.redColor
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'motion-form'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-form

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

[dscout](https://dscout.com) - for their sponsorship
