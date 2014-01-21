motion_require './base_cell'
motion_require '../views/icon_view'

class TextFieldCell < BaseCell
  IDENTIFIER = 'TextFieldCell'

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.observe('ButtonCallbackWillFire', 'resign_text_view:')
      cell.observe('FormWillValidate',       'resign_text_view:')
      cell.observe('FormWillRender',         'resign_text_view:')

      cell.setup_constraints
    end
  end

  class << self
    def has_value?
      true
    end
  end

  def setup_constraints
    Motion::Layout.new do |layout|
      layout.view       contentView
      layout.subviews   'text_view' => text_view
      layout.horizontal '|[text_view]|'
      layout.vertical   '|[text_view]|'
    end
  end

  def resign_text_view(notification)
    text_view.resignFirstResponder if text_view.isFirstResponder
  end

  def label=(label)
  end

  def placeholder=(placeholder)
    text_view.placeholder = placeholder
  end

  def secure=(secure)
  end

  def icon=(icon)
    left_view.name = icon
  end

  def text_view
    @text_view ||= SZTextView.alloc.init.tap do |text_view|
      text_view.font     = UIFont.fontWithName('HelveticaNeue-Light', size: 14.0)
      text_view.delegate = self
    end
  end
  alias_method :text_field, :text_view

  def left_view
    @left_view ||= IconView.alloc.init
  end

  def value
    text_view.text
  end

  def value=(value)
    text_view.text = value
  end

  def textViewDidBeginEditing(text_view)
    post('FormCellDidBeginEditing', notification_payload)
  end

  def textViewDidEndEditing(text_view)
    post('FormCellDidEndEditing', notification_payload)
  end

  def textFieldShouldReturn(text_view)
    text_view.resignFirstResponder

    true
  end

  def textView(text_view, shouldChangeTextInRange: range, replacementText: text)
    if text == "\n"
      text_view.resignFirstResponder

      false
    else
      true
    end
  end

  def textViewDidChange(text_view)
    line     = text_view.caretRectForPosition(text_view.selectedTextRange.start)
    overflow = line.origin.y + line.size.height - (text_view.contentOffset.y + text_view.bounds.size.height - text_view.contentInset.bottom - text_view.contentInset.top )

    if overflow > 0
      offset = text_view.contentOffset
      offset.y += overflow + 7

      UIView.animateWithDuration(0.2, animations: -> {
        text_view.setContentOffset(offset)
      })
    end
  end

  def capitalize=(bool)
    option = bool ? UITextAutocapitalizationTypeSentences : UITextAutocapitalizationTypeNone

    text_view.autocapitalizationType = option
  end

  def notification_payload
    { key: key, value: value, text_field: text_view }
  end
end
