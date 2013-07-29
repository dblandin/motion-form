class TextFieldRow < BaseRow
  attr_accessor :value

  def initialize(key, options)
    super

    listen
  end

  def listen
    observers << notification_center.addObserver(self, selector: 'did_end_editing:', name: 'FormCellDidEndEditing', object: nil)
  end

  def did_end_editing(notification)
    self.value = notification.userInfo[:value] if notification.userInfo[:key] == key
  end

  def textFieldDidEndEditing(text_field)
    self.value = text_field.text
  end

  def cell_type
    TextFieldCell
  end
end
