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

  def listen_to_notifications
    observers << notification_center.addObserver(self, selector: 'tapped:', name: 'FormCellWasTapped', object: nil)
  end

  def tapped(notification)
    if notification.userInfo[:key] == key
      on_tap_callback.call
    end
  end
end
