describe String do
  describe '#titleize' do
    it 'titleizes a string' do
      string = 'an example string'

      string.titleize.should.equal 'An Example String'
    end

    it 'removes underscores' do
      string = 'an_example_string'

      string.titleize.should.equal 'An Example String'
    end
  end
end
