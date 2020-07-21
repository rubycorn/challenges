class Bun
  BunNotFound = Class.new(StandardError)

  Pack = Struct.new(:count, :price)

  attr_reader :name, :code, :packs

  def initialize(opts)
    @name = opts[:name]
    @code = opts[:code]
    @packs = opts[:packs].map { |pack| Pack.new(pack[:count], pack[:price]) }
  end

  def self.find(code)
    raise BunNotFound unless data = YAML.safe_load(File.read('data/buns.yml'))['buns'][code]

    Bun.new(JSON.parse(JSON.dump(data), symbolize_names: true))
  end
end
