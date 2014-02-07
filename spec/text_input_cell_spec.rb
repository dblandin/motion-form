describe TextInputCell do
  before do
    @cell = TextInputCell.alloc.init
  end

  describe '#label=' do
    it 'sets the text field placeholder' do
      @cell.label = 'Email'

      @cell.text_label.text.should.equal 'Email'
    end
  end
end
