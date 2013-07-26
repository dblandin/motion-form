class TextFieldRow
  attr_accessor :key, :options, :cell

  def initialize(key, options)
    self.key    = key
    self.options = options
  end

  def cell_identifier
    TextFieldCell::IDENTIFIER
  end

  def name
    key.to_s.titleize
  end

  def icon
    options.fetch(:icon, :twitter)
  end
end
