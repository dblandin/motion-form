class PasswordController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    form = MotionForm.form_for(view) do |f|
      f.section 'Change Password' do |section|
        section.input :password, icon: :lock
        section.input :password_confirmation, icon: :lock
        section.button :save, action: save
      end
    end
  end

  def save
    lambda { p 'saving password' }
  end
end
