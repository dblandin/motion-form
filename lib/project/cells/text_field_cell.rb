motion_require './base_cell'
motion_require '../views/icon_view'

class TextFieldCell < BaseCell
  IDENTIFIER = 'TextFieldCell'

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.observe('ButtonCallbackWillFire', 'resign_textfield:')
      cell.observe('FormWillValidate',       'resign_textfield:')
      cell.observe('FormWillRender',         'resign_textfield:')
    end
  end

  class << self
    def has_value?
      true
    end
  end

  def resign_textfield(notification)
    text_field.resignFirstResponder if text_field.isFirstResponder
  end

  def label=(label)
    text_field.placeholder = label
  end

  def secure=(secure)
    text_field.secureTextEntry = secure
  end

  def icon=(icon)
    left_view.name = icon
  end

  def text_field
    @text_field ||= UITextField.alloc.init.tap do |field|
      field.autocorrectionType       = UITextAutocorrectionTypeNo
      field.autoresizingMask         = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
      field.backgroundColor          = UIColor.clearColor
      field.clearButtonMode          = UITextFieldViewModeWhileEditing
      field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      field.leftView                 = left_view
      field.leftViewMode             = UITextFieldViewModeAlways
      field.textColor                = UIColor.grayColor

      field.delegate = self
    end
  end

  def left_view
    @left_view ||= IconView.alloc.init
  end

  def value
    text_field.text
  end

  def value=(value)
    text_field.text = value
  end

  def layoutSubviews
    text_field.frame = [[10, 0], [300, 43]]
    left_view.frame  = [[0, 0], [36, 43]]
  end

  def textFieldDidBeginEditing(text_field)
    post('FormCellDidBeginEditing', notification_payload)
  end

  def textFieldDidEndEditing(text_field)
    post('FormCellDidEndEditing', notification_payload)
  end

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder

    true
  end

  def notification_payload
    { key: key, value: value, text_field: text_field }
  end
end
