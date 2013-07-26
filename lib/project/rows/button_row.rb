class ButtonRow
  attr_accessor :name, :options

  def initialize(name, options)
    self.name    = name
    self.options = options
  end

  def cell_identifier
    ButtonCell::IDENTIFIER
  end

  def icon
    options.fetch(:icon, :twitter)
  end

  def accessory
    options.fetch(:accessory, nil)
  end
end
