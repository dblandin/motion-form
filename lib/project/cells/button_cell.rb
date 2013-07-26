class ButtonCell < TextFieldCell
  IDENTIFIER = 'ButtonCell'

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.selectionStyle     = UITableViewCellSelectionStyleGray
      cell.text_field.enabled = false

      cell.add_right_view
    end
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

    right_view.frame = [[270, 0], [36, 43]]
  end
end
