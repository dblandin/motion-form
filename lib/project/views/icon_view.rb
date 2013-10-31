class IconView < UILabel
  attr_reader :name

  def init
    super.tap do |view|
      view.font            = MotionForm.icon_font
      view.backgroundColor = UIColor.clearColor
      view.textColor       = UIColor.grayColor
      view.textAlignment   = NSTextAlignmentCenter
    end
  end

  def name=(name)
    @name = name

    self.text = MotionForm.icon_mapper.call(name)
  end
end
