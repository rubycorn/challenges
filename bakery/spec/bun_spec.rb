describe Bun do
  describe '.find' do
    let (:bun) { Bun.find('VS5') }

    it 'should find a bun by code' do
      expect(bun.class).to eq(Bun)
      expect(bun.name).to eq('Vegemite Scroll')
      expect(bun.code).to eq('VS5')
    end

    it 'should not find a bun by incorrect code' do
      expect { Bun.find('AAA') }.to raise_exception(Bun::BunNotFound)
    end
  end
end