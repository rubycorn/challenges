class Order
  Line = Struct.new(:bun, :count, :sum, :packs)

  attr_reader :lines

  def initialize(data)
    load_lines(data)
  end

  def print
    @lines.each do |line|
      puts "#{line.count} #{line.bun.code} $#{line.sum.round(2)}"
      if line.packs.empty?
        puts "\tNo suitable packs"
      else
        line.packs.each { |pack, count| puts "\t#{count} x #{pack.count} $#{pack.price}" }
      end
    end
  end

  private

  def load_lines(data)
    @lines = []
    data.each do |code, count|
      bun = Bun.find(code)
      packer = Packer.new(bun, count)
      line = Line.new(bun, count, 0, [])
      if result = packer.pack
        line.sum = result.sum
        line.packs = result.packs
      end
      @lines << line
    end
  end
end
