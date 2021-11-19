# frozen_string_literal: true

require File.dirname(__FILE__) + '/lib/simulator'
require 'byebug'

sim = Simulator.new(5, 5)
sim.exec('PLACE 0,0,NORTH')
sim.exec('MOVE')
sim.exec('REPORT')
sim.exec('PLACE 0,0,NORTH')
sim.exec('LEFT')
sim.exec('REPORT')
sim.exec('PLACE 1,2,EAST')
sim.exec('MOVE')
sim.exec('MOVE')
sim.exec('LEFT')
sim.exec('MOVE')
sim.exec('REPORT')
