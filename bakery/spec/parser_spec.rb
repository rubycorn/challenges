describe Parser do
  describe '#parse' do
    context 'when input consists incorrect data' do
      let(:parser) { Parser.new('spec/input/incorrect_code.txt') }

      it 'should show an error message' do
        expect { parser.parse }.to output("Incorrect data in line \"2VS5\\n\"\n").to_stdout
      end
    end

    context 'when input consists doubled codes' do
      let(:parser) { Parser.new('spec/input/doubled.txt') }

      it 'should sum requested counts' do
        expect(parser.parse).to eq({ 'VS5' => 16 })
      end
    end

    context 'when correct filename is provided' do
      let(:parser) { Parser.new('spec/input/correct.txt') }

      it 'should return input data' do
        expect(parser.parse.class).to eq(Hash)
        expect(parser.parse.keys.map(&:class).uniq).to eq([String])
      end
    end
  end
end