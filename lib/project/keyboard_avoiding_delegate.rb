class KeyboardAvoidingDelegate
  KEYBOARD_ANIMATION_DURATION = 0.3
  MINIMUM_SCROLL_FRACTION     = 0.2
  MAXIMUM_SCROLL_FRACTION     = 0.8
  PORTRAIT_KEYBOARD_HEIGHT    = 216.0
  LANDSCAPE_KEYBOARD_HEIGHT   = 162.0

  attr_accessor :view, :animated_distance, :active_text_field

  def initialize(view)
    self.view = view

    add_tap_recognizer
    listen_to_notifications
  end

  def listen_to_notifications
    observers << notification_center.addObserver(self, selector: 'did_begin_editing:', name: 'FormCellDidBeginEditing', object: nil)
    observers << notification_center.addObserver(self, selector: 'did_end_editing:', name: 'FormCellDidEndEditing', object: nil)
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def did_begin_editing(notification)
    textFieldDidBeginEditing(notification.userInfo[:text_field])
  end

  def did_end_editing(notification)
    textFieldDidEndEditing(notification.userInfo[:text_field])
  end

  def observers
    @observers ||= []
  end

  def remove_all_observers
    observers.each do |observer|
      notification_center.removeObserver(observer)
    end
  end

  def dealloc
    remove_all_observers
  end

  def add_tap_recognizer
    view.addGestureRecognizer(tap_recognizer)
  end

  def tap_recognizer
    UITapGestureRecognizer.alloc.initWithTarget(self, action: 'dismiss_keyboard')
  end

  def dismiss_keyboard
    active_text_field.resignFirstResponder if active_text_field
  end

  def textFieldDidBeginEditing(text_field)
    self.active_text_field = text_field

    text_field_rect = view.window.convertRect(text_field.bounds, fromView: text_field)
    view_rect       = view.window.convertRect(view.bounds, fromView: view)
    midline         = text_field_rect.origin.y + 0.5 * text_field_rect.size.height
    numerator       = midline - view_rect.origin.y - MINIMUM_SCROLL_FRACTION * view_rect.size.height
    denominator     = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * view_rect.size.height
    height_fraction = numerator / denominator

    if height_fraction < 0.0
      height_fraction = 0.0
    elsif height_fraction > 1.0
      height_fraction = 1.0
    end

    orientation = UIApplication.sharedApplication.statusBarOrientation
    if orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown
      self.animated_distance = (PORTRAIT_KEYBOARD_HEIGHT * height_fraction).floor
    else
      self.animated_distance = (LANDSCAPE_KEYBOARD_HEIGHT * height_fraction).floor
    end

    view_frame = view.frame
    view_frame.origin.y -= animated_distance

    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(KEYBOARD_ANIMATION_DURATION)

    view.setFrame(view_frame)

    UIView.commitAnimations
  end

  def textFieldDidEndEditing(text_field)
    view_frame = view.frame
    view_frame.origin.y += animated_distance

    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(KEYBOARD_ANIMATION_DURATION)

    view.setFrame(view_frame)

    UIView.commitAnimations
  end

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder

    true
  end
end
