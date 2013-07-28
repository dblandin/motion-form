class PaddedLabel < UILabel
  def drawTextInRect(rect)
    insets = UIEdgeInsets.new(0, padding, 0, padding)

    padded_rect = UIEdgeInsetsInsetRect(rect, insets)

    super(padded_rect)
  end

  def padding=(padding)
    @padding = padding
  end

  def padding
    @padding || 0
  end
end
