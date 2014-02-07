motion_require './text_field_cell'

class ButtonCell < TextInputCell
  IDENTIFIER = 'ButtonCell'

  class << self
    def has_value?
      false
    end
  end

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.selectionStyle     = UITableViewCellSelectionStyleGray
      cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator
      cell.text_field.enabled = false

      cell.text_label.textColor = MotionForm.button_text_color

      cell.add_tap_recognizer
    end
  end

  def setup_constraints
    text_label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(text_label)

    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|-margin-[label]-margin-|',
      options: NSLayoutFormatAlignAllCenterY,
      metrics: { 'margin' => 10 },
      views:   subviews_dict))

    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|[label]|',
      options: 0,
      metrics: {},
      views:   subviews_dict))
  end

  def add_tap_recognizer
    addGestureRecognizer(tap_recognizer)
  end

  def label=(label)
    text_label.text = label
  end

  def tap_recognizer
    UITapGestureRecognizer.alloc.initWithTarget(self, action: 'tapped:')
  end

  def tapped(recognizer)
    post('FormCellWasTapped', notification_payload)
  end

  def notification_payload
    { key: key }
  end
end
