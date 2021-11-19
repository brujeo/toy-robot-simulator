# frozen_string_literal: true

require File.dirname(__FILE__) + '/lib/simulator'
require 'tty-prompt'
require 'byebug'

sim = Simulator.new(5, 5)

status = 'running'
while status == 'running'

  prompt = TTY::Prompt.new
  cmd = prompt.ask('Command > ')

  if %w[EXIT QUIT q].include?(cmd)
    status = 'stopped'
  else
    begin
      sim.exec(cmd)
      system 'clear'
      sim.draw
    rescue StandardError => e
      puts e.message
    end
  end
end
