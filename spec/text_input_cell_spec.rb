describe TextInputCell do
  before do
    @cell = TextInputCell.alloc.init
  end

  describe '#placeholder=' do
    it 'sets the text field placeholder' do
      @cell.placeholder = :email

      @cell.text_field.placeholder.should.equal 'email'
    end
  end
end
