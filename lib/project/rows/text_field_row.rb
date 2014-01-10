motion_require './base_row'
motion_require '../cells/text_field_cell'

class TextFieldRow < TextInputRow
  def cell_type
    TextFieldCell
  end

  def height
    100
  end
end
