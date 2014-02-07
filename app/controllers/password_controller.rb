class PasswordController < UIViewController
  attr_reader :form

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    @form = MotionForm.form_for(view) do |f|
      f.section 'Change Password' do |section|
        section.input :password, icon: :lock
        section.input :password_confirmation, label: 'Confirm', icon: :lock
        section.button :save, action: save
      end
    end
  end

  def save
    -> { p 'saving password', form.render }
  end
end
