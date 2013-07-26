class TextFieldRow
  attr_accessor :value
  attr_reader :icon, :key, :options

  def initialize(key, options)
    @key     = key
    @options = options

    @icon  = options.fetch(:icon, nil)
    @value = options.fetch(:value, nil)
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
