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

    self.text = hex
  end

  def hex
    unicode ? unicode.hex.chr(Encoding::UTF_8) : ''
  end

  def unicode
    icon_mappings[name]
  end

  def icon_mappings
    @_icon_mappings ||= BW::JSON.parse(json_data.to_str)
  end

  def json_data
    NSData.dataWithContentsOfFile(json_path)
  end

  def json_path
    NSBundle.mainBundle.pathForResource('font_icons', ofType: 'json')
  end
end
