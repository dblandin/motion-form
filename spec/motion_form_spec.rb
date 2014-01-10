describe MotionForm do
  it 'allows configuration' do
    font = UIFont.fontWithName('Helvetica', size: 14)

    MotionForm.config do |config|
      config.icon_font = font
    end

    MotionForm.icon_font.should.equal font
  end

  it 'knows about all of the included cells' do
    expected_cells = [TextInputCell, TextFieldCell, ButtonCell]

    MotionForm.included_cells.should.equal expected_cells
  end

  describe '#register_cell' do
    it 'registers a cell' do
      MotionForm.register_cell(UITableViewCell)

      MotionForm.registered_cells.should.include? UITableViewCell
    end
  end
end
