describe MotionForm::Base do
  before do
    @form = MotionForm::Base.new
  end

  it 'starts with an empty array of rows' do
    @form.rows.should.be.empty
  end

  describe '#section' do
    it 'returns a new section' do
      (@form.section {}.is_a? MotionForm::Section).should.be.true
    end
  end

  describe '#render' do
    it 'returns a hash of values' do
      @form.section {|s| s.input :email, value: 'devon@dscout.com' }

      @form.render.should.equal( email: 'devon@dscout.com' )
    end

    it 'does not include non-value rows' do
      @form.section {|s| s.button :submit }

      @form.render.should.equal( {} )
    end
  end
end
