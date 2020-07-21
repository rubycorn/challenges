class Packer
  Node = Struct.new(:count, :sum, :level, :packs)

  def initialize(bun, count)
    @bun = bun
    @count = count
  end

  def pack
    return nil if count < 1

    queue = [Node.new(0, 0, 0, [])]
    while queue.any?
      node = queue.delete_at(0)
      bun.packs.each do |bp|
        child = new_node(node, bp)
        if child.count == count
          child.sum = child.sum.round(2)
          child.packs = child.packs.group_by { |e| e }.map { |k, v| [k, v.length] }.to_h
          return child
        elsif child.count < count
          queue << child
        end
      end
    end
  end

  private

  attr_reader :bun, :count

  def new_node(node, pack)
    child = Node.new

    child[:count] = node.count + pack.count
    child[:sum] = node.sum + pack.price
    child[:level] = node.level + 1
    child[:packs] = node.packs + [pack]

    child
  end
end
