motion_require '../motion_form'

module MotionForm
  class FormController < UIViewController
    attr_reader :form

    def viewDidLoad
      super

      setup_form
    end

    private

    def setup_form
      @form = MotionForm.form_for(view)
    end
  end
end
