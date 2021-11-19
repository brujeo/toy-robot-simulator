# frozen_string_literal: true

require File.dirname(__FILE__) + '/../../lib/simulator'
require 'byebug'

RSpec.describe Simulator, type: :model do
  before(:each) do
    @sim = Simulator.new(5, 5)
  end

  describe '#place command' do
    context 'moving robot' do
      it 'should move robot position on x-axis' do
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.place(1, 0, 'NORTH')
        expect(@sim.instance_variable_get(:@x)).to eq(1)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
      end
      it 'should move robot position on y-axis' do
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.place(0, 1, 'NORTH')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(1)
      end
      it 'should ignore move that is outside of x-axis' do
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.place(10, 0, 'NORTH')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
      end
      it 'should ignore move that is outside of y-axis' do
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.place(0, 10, 'NORTH')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
      end
    end
    context 'rotating robot' do
      it 'should change robot facing' do
        expect(@sim.instance_variable_get(:@f)).to eq(nil)
        @sim.place(0, 1, 'NORTH')
        expect(@sim.instance_variable_get(:@f)).to eq('NORTH')
      end
      it 'should ignore move when direction is invalid' do
        expect(@sim.instance_variable_get(:@f)).to eq(nil)
        @sim.place(0, 0, 'INVALID')
        expect(@sim.instance_variable_get(:@f)).to eq(nil)
      end
    end
    context 'simulator started' do
      it 'should flag simulator as started when first successfull PLACE command executed' do
        expect(@sim.instance_variable_get(:@started)).to eq(false)
        @sim.place(1, 0, 'NORTH')
        expect(@sim.instance_variable_get(:@started)).to eq(true)
      end
      it 'should not flag simulator as started when not valid PLACE command is passed' do
        expect(@sim.instance_variable_get(:@started)).to eq(false)
        @sim.place(10, 10, 'NORTH')
        expect(@sim.instance_variable_get(:@started)).to eq(false)
      end
    end
  end

  describe '#move command' do
    it 'should ignore command if simulater not started (valid place command has not been executed)' do
      expect(@sim.instance_variable_get(:@x)).to eq(0)
      expect(@sim.instance_variable_get(:@y)).to eq(0)
      @sim.move
      expect(@sim.instance_variable_get(:@x)).to eq(0)
      expect(@sim.instance_variable_get(:@y)).to eq(0)
    end
    context 'moving robot' do
      it 'should move robot position on x-axis' do
        @sim.place(0, 0, 'EAST')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.move
        expect(@sim.instance_variable_get(:@x)).to eq(1)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
      end
      it 'should move robot position on y-axis' do
        @sim.place(0, 0, 'NORTH')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.move
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(1)
      end
      it 'should ignore move that is outside of x-axis' do
        @sim.place(0, 0, 'WEST')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.move
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
      end
      it 'should ignore move that is outside of y-axis' do
        @sim.place(0, 0, 'SOUTH')
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
        @sim.move
        expect(@sim.instance_variable_get(:@x)).to eq(0)
        expect(@sim.instance_variable_get(:@y)).to eq(0)
      end
    end
  end

  describe '#left command' do
    it 'should ignore command if simulater not started (valid place command has not been executed)' do
      expect(@sim.instance_variable_get(:@f)).to eq(nil)
      @sim.left
      expect(@sim.instance_variable_get(:@f)).to eq(nil)
    end
    context 'rotating robot' do
      it 'should rotate robot left' do
        @sim.place(0, 0, 'NORTH')
        expect(@sim.instance_variable_get(:@f)).to eq('NORTH')
        @sim.left
        expect(@sim.instance_variable_get(:@f)).to eq('WEST')
      end
      it 'should rotate robot left' do
        @sim.place(0, 0, 'WEST')
        expect(@sim.instance_variable_get(:@f)).to eq('WEST')
        @sim.left
        expect(@sim.instance_variable_get(:@f)).to eq('SOUTH')
      end
    end
  end

  describe '#right command' do
    it 'should ignore command if simulater not started (valid place command has not been executed)' do
      expect(@sim.instance_variable_get(:@f)).to eq(nil)
      @sim.right
      expect(@sim.instance_variable_get(:@f)).to eq(nil)
    end
    context 'rotating robot' do
      it 'should rotate robot right' do
        @sim.place(0, 0, 'NORTH')
        expect(@sim.instance_variable_get(:@f)).to eq('NORTH')
        @sim.right
        expect(@sim.instance_variable_get(:@f)).to eq('EAST')
      end
      it 'should rotate robot right' do
        @sim.place(0, 0, 'EAST')
        expect(@sim.instance_variable_get(:@f)).to eq('EAST')
        @sim.right
        expect(@sim.instance_variable_get(:@f)).to eq('SOUTH')
      end
    end
  end
end
