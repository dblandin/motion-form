motion_require '../motion_form'
motion_require './padded_label'

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
      label.adjustsFontSizeToFitWidth = true
      label.backgroundColor           = MotionForm.section_header_color
      label.font                      = MotionForm.section_header_font
      label.padding                   = 10
      label.textColor                 = MotionForm.section_header_text_color
    end
  end
end
