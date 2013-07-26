describe ButtonCell do
  before do
    @cell = ButtonCell.new
  end

  it 'has a forward arrow accessory view' do
    @cell.right_view.name.should.equal :forward_arrow
  end
end
