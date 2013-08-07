motion_require './cells/button_cell'
motion_require './cells/text_field_cell'

module MotionForm
  class << self
    attr_writer :icon_font, :section_header_color, :section_header_text_color

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

    def icon_font
      @icon_font || UIFont.fontWithName('dscovr', size: 14.0)
    end

    def section_header_color
      @section_header_color || '#bac3c7'.to_color
    end

    def section_header_text_color
      @section_header_text_color || '#eaf0f1'.to_color
    end
  end
end
