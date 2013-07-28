module MotionForm
  class FormController < UIViewController
    attr_reader :form

    def viewDidLoad
      super

      setup_form
    end

    private

    def setup_form
      @form = MotionForm.form_for(view) do |f|
        f.section do |section|
          section.input :name
        end
      end
    end
  end
end

describe MotionForm::FormController do
  tests MotionForm::FormController

  it 'it provides a form for you' do
    views(MotionForm::Base).should.not.be.nil

    view('Name').should.not.be.nil
    tap('Name')
    views(UITextField).first.text = 'Devon Blandin'
    views(UITextField).first.resignFirstResponder
  end
end
