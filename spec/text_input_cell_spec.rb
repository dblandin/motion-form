describe TextInputCell do
  before do
    @cell = TextInputCell.alloc.init
  end

  describe '#label=' do
    it 'sets the text field placeholder' do
      @cell.label = :email

      @cell.text_field.placeholder.should.equal 'email'
    end
  end

  describe '#icon=' do
    it 'sets the icon view name' do
      @cell.icon = :website

      @cell.left_view.name.should.equal :website
    end
  end
end
