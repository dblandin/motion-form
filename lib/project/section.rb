class MotionForm
  class Section
    def input(key, options = {})
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
