class FormController < UIViewController
  URL_REGEX = /https?:\/\/[\S]+/

  attr_reader :form

  def viewDidLoad
    super

    view.backgroundColor = '#EFEFF4'.to_color
    self.title = 'Me'

    @form = MotionForm.form_for(view) do |form|
      form.backgroundColor = '#EFEFF4'.to_color
      form.section 'Profile' do |section|
        section.input :name,      label: 'Full Name', placeholder: 'Your name', value: 'David Copperfield'
        section.input :username,  placeholder: 'A username'
        section.input :pinterest, placeholder: 'Pinterest username'
        section.input :twitter,   placeholder: 'Twitter username'
        section.input :website,   placeholder: 'Personal blog or website', validate_with: url_validator

        section.button :submit, action: submit
      end

      form.section 'Bio' do |section|
        section.text  :bio, placeholder: 'Write a short bio...'
      end

      form.section 'Account' do |section|
        section.button :change_password, action: notify_action
      end
    end
  end

  def submit
    -> { App.alert form.valid? ? 'Form is valid' : 'Form is invalid' }
  end

  def url_validator
    -> (value) { value && value[URL_REGEX] }
  end

  def notify_action
    -> { navigationController.pushViewController(password_controller, animated: true) }
  end

  def password_controller
    PasswordController.alloc.init
  end
end
