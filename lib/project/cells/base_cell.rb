class BaseCell < UITableViewCell
  attr_accessor :key

  class << self
    def has_value?
      false
    end
  end

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.selectionStyle         = UITableViewCellSelectionStyleNone
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

  def post(notification, payload = nil)
    notification_center.postNotificationName(notification, object: self, userInfo: payload)
  end

  def observe(notification_name, selector)
    notification_center.addObserver(self, selector: selector, name: notification_name, object: nil)
  end

  def dealloc
    notification_center.removeObserver(self)
  end
end
