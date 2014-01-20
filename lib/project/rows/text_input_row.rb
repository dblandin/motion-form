motion_require './base_row'
motion_require '../cells/text_input_cell'

class TextInputRow < BaseRow
  EMAIL_REGEX = /^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  URL_REGEX   = /https?:\/\/[\S]+/

  attr_accessor :value

  def initialize(key, options)
    super

    setup_validation

    listen
  end

  def setup_validation
    if options[:required]
      validation_rules << lambda { |value| value && value != '' }
    end

    if options[:email]
      validation_rules << lambda { |value| value && value[EMAIL_REGEX] }
    end

    if options[:url]
      validation_rules << lambda { |value| value && value[URL_REGEX] }
    end

    if options[:format] && options[:format].is_a?(Regexp)
      validation_rules << lambda { |value| value && value[options[:format]] }
    end

    if options[:validate_with] && options[:validate_with].is_a?(Proc)
      validation_rules << options[:validate_with]
    end
  end

  def valid?
    validation_rules.all? { |rule| rule.call(value) }
  end

  def validation_rules
    @validation_rules ||= []
  end

  def listen
    observe('FormCellDidEndEditing', 'did_end_editing:')
  end

  def did_end_editing(notification)
    self.value = notification.userInfo[:value] if notification.userInfo[:key] == key
  end

  def textFieldDidEndEditing(text_field)
    self.value = text_field.text
  end

  def update_cell(cell)
    super

    cell.secure     = options[:secure]
    cell.value      = options[:value]
    cell.capitalize = capitalize?
  end

  def capitalize?
    options[:capitalize] || !(options[:email] || options[:secure])
  end

  def cell_type
    TextInputCell
  end
end
