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
        f.input :name
      end
    end
  end
end

describe MotionForm::FormController do
  tests MotionForm::FormController

  it 'it provides a form for you' do
    views(MotionForm::Base).should.not.be.nil

    view('Name').should.not.be.nil
  end
end
