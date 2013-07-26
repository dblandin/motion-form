class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions: launch_options)
    return true if RUBYMOTION_ENV == 'test'

    MotionForm.config do |config|
      config.icon_font = UIFont.fontWithName('dscovr', size: 14.0)
    end

    initialize_main_controller

    true
  end

  private

  def initialize_main_controller
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    window.setRootViewController(ViewController.alloc.init)

    window.makeKeyAndVisible
  end
end
