# motion-form

RubyMotion forms made easy.

motion-form is heavily inspired by the gem simple_form for Rails.

It aims to bring a simple, yet flexible DSL to the tedious task of creating iOS forms.

## Usage

```ruby
form = MotionForm.form_for(view) do |f|
  f.section 'Profile' do |section|
    section.input :name,      icon: :contact
    section.input :username,  icon: :user
    section.input :pinterest, icon: :pinterest
    section.input :twitter,   icon: :twitter
    section.input :website,   icon: :website
    section.input :bio,       icon: :info
  end

  f.section 'Account' do |section|
    section.button :change_email, icon: :email, action: push_email_controller
    section.button :change_password, icon: :lock, action: push_password_controller
  end
end

def push_email_controller
  # push controller
end

def push_password_controller
  # push controller
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
