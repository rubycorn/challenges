describe Order do
  describe '#initialize' do
    let (:order) { Order.new(Parser.new('spec/input/correct.txt').parse) }

    it 'should have calculated data in line 0' do
      expect(order.lines[0].class).to eq(Order::Line)
      expect(order.lines[0].bun.code).to eq('VS5')
      expect(order.lines[0].count).to eq(10)
      expect(order.lines[0].sum).to eq(17.98)
    end

    it 'should have calculated data in line 1' do
      expect(order.lines[1].class).to eq(Order::Line)
      expect(order.lines[1].bun.code).to eq('MB11')
      expect(order.lines[1].count).to eq(14)
      expect(order.lines[1].sum).to eq(54.8)
    end

    it 'should have calculated data in line 2' do
      expect(order.lines[2].class).to eq(Order::Line)
      expect(order.lines[2].bun.code).to eq('CF')
      expect(order.lines[2].count).to eq(13)
      expect(order.lines[2].sum).to eq(25.85)
    end
  end

  describe '#print' do
    let (:order) { Order.new(Parser.new('spec/input/doubled.txt').parse) }

    it 'should render the order in requested format' do
      out = "16 VS5 $31.96\n\t2 x 3 $6.99\n\t2 x 5 $8.99\n"
      expect { order.print }.to output(out).to_stdout
    end
  end
end