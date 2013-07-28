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

  def tap_recognizer
    UITapGestureRecognizer.alloc.initWithTarget(self, action: 'tapped:')
  end

  def tapped(recognizer)
    post('FormCellWasTapped')
  end

  def add_right_view
    text_field.rightView     = right_view
    text_field.rightViewMode = UITextFieldViewModeAlways
  end

  def right_view
    @right_view ||= IconView.alloc.init.tap do |icon|
      icon.name = :forward_arrow
    end
  end

  def layoutSubviews
    super

    right_view.frame = [[size.width - 56, 0], [36, 43]]
  end
end
