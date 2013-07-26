class TextFieldCell < UITableViewCell
  IDENTIFIER = 'TextFieldCell'

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.selectionStyle = UITableViewCellSelectionStyleNone

      cell.contentView.addSubview(text_field)
    end
  end

  def label=(label)
    text_field.placeholder = label
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
    end
  end

  def left_view
    @left_view ||= IconView.alloc.init
  end

  def layoutSubviews
    text_field.frame = [[10, 0], [300, 43]]
    left_view.frame  = [[0, 0], [36, 43]]
  end
end
