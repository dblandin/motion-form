class TextFieldRow
  attr_accessor :name, :options, :cell

  def initialize(name, options)
    self.name    = name
    self.options = options
  end

  def cell_identifier
    TextFieldCell::IDENTIFIER
  end

  def icon
    options.fetch(:icon, :twitter)
  end
end
