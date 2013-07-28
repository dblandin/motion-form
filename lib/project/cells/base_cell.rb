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
    end
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def post(notification)
    notification_center.postNotificationName(notification, object: self, userInfo: { key: key, value: value })
  end
end
