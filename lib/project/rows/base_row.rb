class BaseRow
  attr_reader :icon, :key, :options

  def initialize(key, options)
    @key     = key
    @options = options

    @icon  = options.fetch(:icon, nil)
    @value = options.fetch(:value, nil)
  end

  def observers
    @observers ||= []
  end

  def remove_all_observers
    observers.each do |observer|
      notification_center.removeObserver(observer)
    end
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def cell_identifier
    cell_type::IDENTIFIER
  end

  def has_value?
    cell_type.has_value?
  end

  def update_cell(cell)
    cell.key   = key
    cell.label = name
    cell.icon  = icon
  end

  def name
    key.to_s.titleize
  end
end
