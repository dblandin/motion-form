class FormController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
    self.title = 'Settings'

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
        section.button :change_password, icon: :lock, action: notify_action
        section.button :change_email, icon: :email, action: notify_action
      end
    end
  end

  def notify_action
    lambda do
      navigationController.pushViewController(password_controller, animated: true)
    end
  end

  def password_controller
    PasswordController.alloc.init
  end
end
