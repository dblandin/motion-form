class ButtonRow < TextFieldRow
  def cell_type
    ButtonCell
  end

  def accessory
    options.fetch(:accessory, nil)
  end
end
