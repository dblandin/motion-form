module MotionForm
  class << self
    attr_accessor :icon_font

    def config(&block)
      yield self
    end

    def form_for(view, &block)
      MotionForm::Base.new.tap do |form|

        yield form

        view.addSubview(form)
      end
    end
  end
end
