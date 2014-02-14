motion_require './base_cell'

class TextInputCell < BaseCell
  IDENTIFIER = 'TextInputCell'

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.setup_constraints

      cell.observe('ButtonCallbackWillFire', 'resign_textfield:')
      cell.observe('FormWillValidate',       'resign_textfield:')
      cell.observe('FormWillRender',         'resign_textfield:')
    end
  end

  def setup_constraints
    [text_label, text_field].each do |subview|
      subview.translatesAutoresizingMaskIntoConstraints = false

      contentView.addSubview(subview)
    end

    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|-margin-[label(100@1000)][input]-margin-|',
      options: NSLayoutFormatAlignAllCenterY,
      metrics: { 'margin' => 10 },
      views:   subviews_dict))

    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|[label]|',
      options: 0,
      metrics: {},
      views:   subviews_dict))

    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|[input]|',
      options: 0,
      metrics: {},
      views:   subviews_dict))
  end

  def subviews_dict
    { 'label' => text_label,
      'input' => text_field }
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
    text_label.text = label
  end

  def secure=(secure)
    text_field.secureTextEntry = secure
  end

  def placeholder=(placeholder)
    text_field.placeholder = placeholder
  end

  def text_field
    @text_field ||= UITextField.alloc.init.tap do |field|
      field.autocorrectionType       = UITextAutocorrectionTypeNo
      field.backgroundColor          = UIColor.clearColor
      field.clearButtonMode          = UITextFieldViewModeWhileEditing
      field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      field.textColor                = UIColor.darkGrayColor
      field.font                     = UIFont.fontWithName('HelveticaNeue-Light', size: 16.0)

      field.delegate = self
    end
  end

  def text_label
    @text_label ||= UILabel.alloc.init.tap do |label|
      label.textColor = UIColor.darkGrayColor
      label.font      = UIFont.fontWithName('HelveticaNeue-Light', size: 18.0)
    end
  end

  def value
    text_field.text
  end

  def value=(value)
    text_field.text = value
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

  def capitalize=(bool)
    option = bool ? UITextAutocapitalizationTypeSentences : UITextAutocapitalizationTypeNone

    text_field.autocapitalizationType = option
  end

  def notification_payload
    { key: key, value: value, text_field: text_field }
  end
end
