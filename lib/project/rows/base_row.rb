class BaseRow
  attr_reader :key, :label, :options

  def initialize(key, options)
    @key     = key
    @options = options

    @label = options.fetch(:label, key.to_s.titleize)
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def post(notification)
    notification_center.postNotificationName(notification, object: self, userInfo: nil)
  end

  def observe(notification_name, selector)
    notification_center.addObserver(self, selector: selector, name: notification_name, object: nil)
  end

  def dealloc
    notification_center.removeObserver(self)
  end

  def cell_identifier
    cell_type::IDENTIFIER
  end

  def has_value?
    cell_type.has_value?
  end

  def update_cell(cell)
    cell.key         = key
    cell.label       = label
    cell.placeholder = options.fetch(:placeholder, nil)
  end
end
