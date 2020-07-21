require 'byebug'
require 'yaml'
require 'json'

require 'bun'
require 'packer'
require 'order'
require 'parser'

RSpec.configure do |config|
  config.color = true
  config.order = :random
end
