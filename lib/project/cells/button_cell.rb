motion_require './text_field_cell'

class ButtonCell < TextFieldCell
  IDENTIFIER = 'ButtonCell'

  class << self
    def has_value?
      false
    end
  end

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.selectionStyle     = UITableViewCellSelectionStyleGray
      cell.text_field.enabled = false

      cell.add_right_view
      cell.add_tap_recognizer
    end
  end

  def add_tap_recognizer
    addGestureRecognizer(tap_recognizer)
  end

  def label=(label)
    text_field.attributedPlaceholder = build_highlighted_placeholder(label)
  end

  def build_highlighted_placeholder(label)
    NSAttributedString.alloc.initWithString(
      label,
      attributes: { NSForegroundColorAttributeName =>  MotionForm.button_text_color })
  end

  def tap_recognizer
    UITapGestureRecognizer.alloc.initWithTarget(self, action: 'tapped:')
  end

  def tapped(recognizer)
    post('FormCellWasTapped', notification_payload)
  end

  def add_right_view
    text_field.rightView     = right_view
    text_field.rightViewMode = UITextFieldViewModeAlways
  end

  def accessory=(icon)
    right_view.name = icon
  end

  def right_view
    @right_view ||= IconView.alloc.init
  end

  def layoutSubviews
    super

    right_view.frame = [[size.width - 56, 0], [36, 43]]
  end

  def notification_payload
    { key: key }
  end
end
