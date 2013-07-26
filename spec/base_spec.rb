describe MotionForm::Base do
  before do
    @form = MotionForm::Base.new
  end

  it 'starts with an empty array of rows' do
    @form.rows.should.be.empty
  end

  describe '#input' do
    it 'adds a new input to the form' do
      @form.input :email

      @form.rows.count.should.equal 1
      (@form.rows.first.is_a? TextFieldRow).should.be.true
    end
  end

  describe '#button' do
    it 'adds a new button to the form' do
      @form.button :submit

      @form.rows.count.should.equal 1
      (@form.rows.first.is_a? ButtonRow).should.be.true
    end
  end

  describe '#section' do
    it 'returns a new section' do
      (@form.section.is_a? MotionForm::Section).should.be.true
    end
  end
end
