motion_require './base_row'
motion_require '../cells/text_field_cell'

class TextFieldRow < BaseRow
  attr_accessor :value

  def initialize(key, options)
    super

    listen
  end

  def listen
    observe('FormCellDidEndEditing', 'did_end_editing:')
  end

  def did_end_editing(notification)
    self.value = notification.userInfo[:value] if notification.userInfo[:key] == key
  end

  def textFieldDidEndEditing(text_field)
    self.value = text_field.text
  end

  def update_cell(cell)
    super

    cell.secure = options[:secure]
    cell.value  = options[:value]
  end

  def cell_type
    TextFieldCell
  end
end
