class TextFieldRow
  attr_accessor :value
  attr_reader :icon, :key, :options

  def initialize(key, options)
    @key     = key
    @options = options

    @icon  = options.fetch(:icon, nil)
    @value = options.fetch(:value, nil)
  end

  def listen_to_notifications
    observers << notification_center.addObserver(self, selector: 'did_begin_editing:', name: 'FormCellDidBeginEditing', object: nil)
    observers << notification_center.addObserver(self, selector: 'did_end_editing:', name: 'FormCellDidEndEditing', object: nil)
  end

  def observers
    @observers ||= []
  end

  def viewDidAppear(animated)
    listen_to_notifications
  end

  def viewWillDisappear(animated)
    remove_all_observers
  end

  def remove_all_observers
    observers.each do |observer|
      notification_center.removeObserver(observer)
    end
  end

  def did_begin_editing(notification)
  end

  def did_end_editing(notification)
    self.value = notification.userInfo[:value] if notification.userInfo[:key] == key
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def cell_type
    TextFieldCell
  end

  def cell_identifier
    cell_type::IDENTIFIER
  end

  def update_cell(cell)
    cell.key   = key
    cell.label = name
    cell.icon  = icon
  end

  def name
    key.to_s.titleize
  end

  def has_value?
    cell_type.has_value?
  end
end
