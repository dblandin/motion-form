class BaseCell < UITableViewCell
  attr_accessor :key

  class << self
    def has_value?
      false
    end
  end

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.selectionStyle = UITableViewCellSelectionStyleNone
      cell.contentView.addSubview(text_field)
      cell.selectedBackgroundView = selected_background_view
    end
  end

  def selected_background_view
    UIView.alloc.initWithFrame(bounds).tap do |view|
      view.backgroundColor = 'FFCDCB'.to_color
    end
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def post(notification)
    notification_center.postNotificationName(notification, object: self, userInfo: notification_payload)
  end
end
