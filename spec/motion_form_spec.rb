describe MotionForm do
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
