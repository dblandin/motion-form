class SectionHeaderView < UIView
  def initWithFrame(frame)
    super.tap do |view|
      view.addSubview(section_title)
    end
  end

  def text=(text)
    section_title.text = text
  end

  def section_title
    @section_title ||= PaddedLabel.alloc.initWithFrame(bounds).tap do |label|
      label.padding = 10
      label.backgroundColor = UIColor.redColor
      label.adjustsFontSizeToFitWidth = true
      label.textColor = UIColor.whiteColor
      label.font = UIFont.fontWithName('Helvetica Neue', size: 20.0)
    end
  end
end
