class ViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    form = MotionForm.form_for(view) do |f|
      f.frame = view.bounds
      f.input :name,      icon: :contact
      f.input :username,  icon: :user
      f.input :pinterest, icon: :pinterest
      f.input :twitter,   icon: :twitter
      f.input :website,   icon: :website
      f.input :bio,       icon: :info

      f.button :change_password, icon: :lock, accessory: :forward_arrow
      f.button :change_email,    icon: :email, accessory: :forward_arrow
      f
    end

    p form.render
  end
end
