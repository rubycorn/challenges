class Parser
  def initialize(path)
    @path = path
  end

  def parse
    data = {}
    errors = []

    File.open(@path) do |f|
      f.each_line do |line|
        begin
          args = line.strip.split
          count = Integer(args.first)
          code = Bun.find(args.last).code
          data[code] = (data[code] || 0) + count
        rescue StandardError
          errors << "Incorrect data in line #{line.inspect}"
        end
      end
    end

    if errors.any?
      puts errors.join("\n")
    else
      data
    end
  end
end
