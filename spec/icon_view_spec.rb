describe IconView do
  before do
    @icon_view = IconView.new
  end

  it 'sets the label text to the hex icon' do
    @icon_view.name = :pinterest

    pinterest_hex = "\xEF\x83\x92"
    @icon_view.text.should.equal pinterest_hex
  end

  it 'sets the label text to nothing if no icon is found' do
    @icon_view.name = :does_not_exist

    @icon_view.text.should.equal ''
  end
end
