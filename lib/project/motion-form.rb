module MotionForm
  class << self
    attr_accessor :icon_font

    def config
      yield self
    end

    def form_for(view)
      MotionForm::Base.new.tap do |form|

        yield form if block_given?

        form.frame = view.bounds

        view.addSubview(form)
      end
    end

    def register_cell(cell)
      registered_cells << cell
    end

    def registered_cells
      @registered_cells ||= included_cells
    end

    def included_cells
      [TextFieldCell, ButtonCell]
    end
  end
end
