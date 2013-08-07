motion_require '../cells/button_cell'
motion_require './text_field_row'

class ButtonRow < TextFieldRow
  attr_reader :on_tap_callback

  def initialize(key, options)
    super

    @on_tap_callback = options.fetch(:action, lambda {})
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
end
