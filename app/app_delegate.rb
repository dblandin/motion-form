class AppDelegate
  attr_accessor :window, :form

  def application(application, didFinishLaunchingWithOptions: launch_options)
    return true if RUBYMOTION_ENV == 'test'

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
