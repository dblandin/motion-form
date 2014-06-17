module MotionForm
  class << self
    attr_writer :section_header_color,
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
      @section_header_font || UIFont.fontWithName('HelveticaNeue', size: 14.0)
    end

    def section_header_color
      @section_header_color || '#EFEFF4'.to_color
    end

    def section_header_text_color
      @section_header_text_color || '#232323'.to_color
    end

    def button_text_color
      @button_text_color || '#232323'.to_color
    end
  end
end
