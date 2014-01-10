motion_require '../cells/button_cell'
motion_require './text_field_row'

class ButtonRow < TextInputRow
  attr_reader :on_tap_callback, :accessory

  def initialize(key, options)
    super

    @on_tap_callback = options.fetch(:action, lambda {})
    @accessory       = options.fetch(:accessory, nil)
  end

  def cell_type
    ButtonCell
  end

  def accessory
    options.fetch(:accessory, nil)
  end

  def listen
    observe('FormCellWasTapped', 'tapped:')
  end

  def tapped(notification)
    if notification.userInfo[:key] == key
      post('ButtonCallbackWillFire')

      on_tap_callback.call
    end
  end

  def update_cell(cell)
    super

    cell.accessory = accessory
  end
end
