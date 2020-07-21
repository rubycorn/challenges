describe Packer do
  describe '#pack' do
    let(:bun) { Bun.find('VS5') }

    context 'when no solution for desired count' do
      it 'should return nil' do
        expect(Packer.new(bun, 2).pack).to eq(nil)
      end
    end

    context 'when incorrect argumets are passed' do
      it 'should return nil' do
        expect(Packer.new(bun, 1).pack).to eq(nil)
      end
    end

    context 'when solution is possible' do
      it 'should return Packer::Node struct' do
        expect(Packer.new(bun, 10).pack.class).to eq(Packer::Node)
      end

      it 'should include packs count for desired count' do
        expect(Packer.new(bun, 10).pack.level).to eq(2)
      end

      it 'should include sum for desired count' do
        expect(Packer.new(bun, 10).pack.sum).to eq(17.98)
      end

      it 'should provide best solution' do
        bun = Bun.new(name: 'Bun', code: 'BU6', packs: [
          { count: 3, price: 4.99 },
          { count: 4, price: 7.99 }
        ])
        expect(Packer.new(bun, 12).pack.level).to eq(3)
        expect(Packer.new(bun, 12).pack.level).not_to eq(4)
      end
    end
  end
end
