class FormController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    form = MotionForm.form_for(view) do |f|
      f.frame = view.bounds

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
    lambda { p 'action' }
  end
end
