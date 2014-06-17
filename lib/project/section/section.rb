motion_require '../rows/text_input_row'
motion_require '../rows/text_field_row'
motion_require '../rows/button_row'

class MotionForm
  class Section
    attr_reader :title

    def initialize(title = '')
      @title = title
    end

    def input(key, options = {})
      rows << TextInputRow.new(key, options)
    end

    def text(key, options = {})
      rows << TextFieldRow.new(key, options)
    end

    def button(key, options = {})
      rows << ButtonRow.new(key, options)
    end

    def rows
      @rows ||= []
    end
  end
end
