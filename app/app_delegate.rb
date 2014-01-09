class AppDelegate
  attr_accessor :window, :form

  def application(application, didFinishLaunchingWithOptions: launch_options)
    return true if RUBYMOTION_ENV == 'test'

    MotionForm.config do |config|
      config.icon_font         = UIFont.fontWithName('icons', size: 14.0)
      config.button_text_color = '#EB5D4E'.to_color
    end

    initialize_main_controller

    true
  end

  private

  def initialize_main_controller
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    window.setRootViewController(nav_controller)

    window.makeKeyAndVisible
  end

  def nav_controller
    UINavigationController.alloc.initWithRootViewController(form_controller)
  end

  def form_controller
    FormController.alloc.init
  end
end
