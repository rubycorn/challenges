#!/usr/bin/env ruby
require 'byebug'
require 'amazing_print'

class Node
  attr_reader :lane, :row
  attr_accessor :distance, :visited, :neighbours

  def initialize(row, lane, distance)
    @row = row
    @lane = lane
    @distance = distance
    @neighbours = []
    @visited = false
  end

  def inspect
    s = neighbours.map { |n| "#{n.row}:#{n.lane}" }
    "<distance:#{distance} row:#{row} lane:#{lane} visited:#{visited} neighbours:#{s}>"
  end
end

class Solution
  def initialize(obstacle_lanes)
    @obstacle_lanes = obstacle_lanes
    @max_distance = obstacle_lanes.size * 2

    build_graph
  end

  def calculate
    queue = [nodes[0][2]]
    while queue.any?
      node = queue.shift

      node.neighbours.each do |neighbour|
        step = node.row == neighbour.row ? 1 : 0
        neighbour.distance = [neighbour.distance, node.distance + step].min
        queue << neighbour if !neighbour.visited && queue.index(neighbour).nil?
      end
      node.visited = true
    end

    (1..3).map { |lane| nodes[obstacle_lanes.size][lane].distance }.min
  end

  private

  attr_reader :max_distance, :obstacle_lanes
  attr_accessor :nodes

  def build_graph
    self.nodes = {}
    (0..obstacle_lanes.size).each do |row|
      nodes[row] = {}
      (1..3).each { |lane| nodes[row][lane] = Node.new(row, lane, max_distance) }
      (1..3).each { |lane| add_neighbours(row, lane) }
    end
    nodes[0][2].distance = 0
  end

  def add_neighbours(row, lane)
    ([1,2,3] - [lane]).each do |neighbour_lane|
      nodes[row][lane].neighbours << nodes[row][neighbour_lane]
    end

    if row > 0 && obstacle_lanes[row-1] != lane
      nodes[row-1][lane].neighbours << nodes[row][lane]
    end
  end
end

obstacle_lanes = [
  1, 3, 2, 3, 3, 2, 1, 2, 2, 3, 1, 1, 3, 1, 3, 1, 1, 3, 3, 3, 1, 2, 1, 1, 1, 1, 1, 1, 3, 2, 1,
  1, 3, 2, 3, 2, 1, 3, 2, 3, 3, 2, 1, 1, 3, 1, 3, 3, 2, 3, 1, 3, 1, 3, 2, 2, 3, 1, 1, 2, 1, 2,
  2, 2, 3, 2, 3, 1, 2, 2, 3, 1, 1, 3, 1, 3, 2, 2, 2, 1, 1, 2, 3, 3, 2, 1, 1, 2, 1, 2, 1, 1, 1,
  2, 1, 2, 1, 2, 3, 2, 2, 3, 2, 3, 1, 1, 1, 2, 1, 3, 3, 2, 3, 1, 2, 2, 3, 2, 1, 3, 1, 2, 2, 3,
  3, 3, 1, 1, 3, 1, 2, 3, 2, 3, 2, 3, 1, 3, 2, 3, 3, 1, 1, 3, 3, 1, 1, 2, 3, 2, 3, 1, 3, 1, 1,
  1, 1, 2, 2, 3, 1, 1, 1, 3, 2, 1, 3, 1, 1, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 3, 3, 3, 3, 2, 3, 2,
  2, 1, 3, 1, 3, 1, 3, 2, 2, 3, 3, 2, 1, 1, 2, 3, 3, 1, 2, 1, 1, 3, 2, 2, 3, 1, 3, 1, 3, 1, 3,
  1, 2, 2, 3, 1, 1, 1, 2, 1, 2, 3, 2, 2, 3, 1, 1, 3, 1, 1, 3, 2, 1, 1, 3, 1, 3, 2, 3, 1, 3, 1,
  3, 3, 2, 2, 3, 1, 2, 1, 3, 1, 1, 1, 3, 3, 3, 2, 3, 3, 2, 3, 3, 1, 2, 2, 3, 1, 1, 1, 3, 1, 3,
  2, 2, 3, 1, 3, 2, 3, 1, 1, 2, 1, 1, 3, 2, 2, 2, 1, 1, 1, 3, 1, 1, 1, 2, 2, 3, 2, 1, 2, 3, 3,
  3, 3, 2, 3, 1, 3, 2, 2, 1, 1, 2, 1, 3, 2, 1, 2, 2, 1, 1, 1, 2, 1, 3, 1, 2, 3, 2, 2, 2, 3, 2,
  3, 1, 1, 1, 1, 3, 2, 3, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 1, 1, 2, 1, 1, 1, 1, 3, 3, 3,
  2, 3, 1, 2, 3, 1, 1, 1, 3, 1, 2, 3, 1, 1, 1, 1, 3, 1, 3, 3, 2, 3, 2, 3, 3, 3, 2, 3, 1, 2, 3,
  2, 3, 2, 1, 2, 3, 1, 3, 3, 1, 2, 3, 2, 3, 3, 1, 1, 2, 3, 3, 2, 1, 1, 3, 1, 3, 2, 3, 2, 3, 3,
  2, 2, 3, 1, 3, 2, 3, 2, 3, 1, 1, 1, 3, 3, 3, 2, 1, 3, 3, 2, 1, 2, 1, 1, 3, 2, 2, 1, 2, 1, 2,
  3, 3, 3, 1, 1, 2, 1, 3, 3, 3, 2, 2, 2, 3, 2, 2, 1, 1, 1, 2, 2, 2, 1, 3, 3, 3, 2, 1, 2, 3, 3,
  3, 3, 2, 1, 1, 2, 3, 3, 3, 1, 2, 3, 3, 2, 3, 3, 2, 2, 1, 2, 2, 3, 2, 3, 1, 2, 2, 2, 1, 1, 1,
  1, 1, 2, 3, 2, 2, 2, 3, 2, 2, 1, 1, 3, 1, 1, 3, 3, 2, 2, 1, 2, 3, 2, 1, 1, 1, 1, 3, 3, 2, 3,
  2, 1, 1, 1, 1, 1, 3, 3, 2, 3, 1, 1, 2, 3, 3, 2, 3, 3, 2, 1, 3, 3, 1, 3, 1, 3, 3, 3, 2, 1, 2,
  3, 2, 3, 3, 3, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 3, 2, 2, 2, 2, 1
]
p Solution.new(obstacle_lanes).calculate