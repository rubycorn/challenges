#!/usr/bin/ruby

require 'webrick'
require 'net/http'
require 'json'

# Base class for media readers
class MediaReader
  attr_reader :path, :status, :data

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < MediaReader }
  end

  def read
    response = Net::HTTP.get_response(uri)
    @status = response.code
    return unless @status == '200'

    @data = JSON.parse(response.body)
  end

  private

  def uri
    URI('https://takehome.io/' << path)
  end
end

# Twitter reader
class TwitterReader < MediaReader
  def initialize
    @path = 'twitter'
  end
end

# Facebook reader
class FacebookReader < MediaReader
  def initialize
    @path = 'facebook'
  end
end

# Instagram reader
class InstagramReader < MediaReader
  def initialize
    @path = 'instagram'
  end
end

# Collector loads readers and stores status and data, it works
# with any of MediaReader's descendants instances, each in own thread
class DataCollector
  attr_reader :json

  def run
    data = run_readers
    @json = JSON.generate(data)
  end

  private

  def run_readers
    readers = MediaReader.descendants.map(&:new)
    threads = readers.map do |reader|
      Thread.new do
        reader.read while reader.status != '200'
      end
    end
    threads.each(&:join)

    readers.map { |reader| [reader.path, reader.data] }.to_h
  end
end

# Main application class
class AppServer
  def start
    server = WEBrick::HTTPServer.new(Port: 3000, DocumentRoot: '.')
    server.mount_proc '/' do |_, response|
      response['Content-Type'] = 'application/json'
      collector = DataCollector.new
      collector.run
      response.status = 200
      response.body = collector.json
    end
    trap('INT') { server.shutdown }
    server.start
  end
end

app = AppServer.new
app.start
