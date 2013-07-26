class ButtonRow < TextFieldRow
  def cell_identifier
    ButtonCell::IDENTIFIER
  end

  def accessory
    options.fetch(:accessory, nil)
  end
end
