motion_require './cells/button_cell'
motion_require './cells/text_field_cell'

module MotionForm
  class << self
    attr_writer :icon_font,
                :icon_mapper,
                :section_header_color,
                :section_header_text_color,
                :section_header_font,
                :button_text_color

    def config
      yield self
    end

    def form_for(view)
      MotionForm::Base.new.tap do |form|

        yield form if block_given?

        view.addSubview(form)

        %w(H V).each do |direction|
          constraints = NSLayoutConstraint.constraintsWithVisualFormat(
          "#{direction}:|[form]|",
          options: 0,
          metrics: nil,
          views: { 'form' => form } )

          view.addConstraints(constraints)
        end
      end
    end

    def register_cell(cell)
      registered_cells << cell
    end

    def registered_cells
      @registered_cells ||= included_cells
    end

    def included_cells
      [TextInputCell, TextFieldCell, ButtonCell]
    end

    def section_header_font
      @section_header_font || UIFont.fontWithName('HelveticaNeue-Bold', size: 14.0)
    end

    def icon_font
      @icon_font || UIFont.fontWithName('dscovr', size: 14.0)
    end

    def icon_mapper
      @icon_mapper || FontIconMapper
    end

    def section_header_color
      @section_header_color || '#bac3c7'.to_color
    end

    def section_header_text_color
      @section_header_text_color || '#eaf0f1'.to_color
    end

    def button_text_color
      @button_text_color || '#bdc3c7'.to_color
    end
  end
end
