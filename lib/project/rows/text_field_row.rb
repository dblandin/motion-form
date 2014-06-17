motion_require './text_input_row'
motion_require '../cells/text_field_cell'

class TextFieldRow < TextInputRow
  def cell_type
    TextFieldCell
  end

  def height
    100
  end

  def update_cell(cell)
    super

    cell.placeholder = options.fetch(:placeholder, 'Write something...')
  end
end
