describe 'game of life' do
  it 'knows if its alive' do
    alive = true
    expect(alive).to eq(true)
  end

  it 'knows if its dead' do
    alive = false
    expect(alive).to eq(false)
  end

  class TooFewNeighborsError < StandardError
  end

  class TooManyNeighborsError < StandardError
  end

  def is_valid?(num_neighbors)
    Cell.new(num_neighbors).valid_num_of_neighbors?
  end

  class Cell
    def initialize(num_neighbors)
      @num_neighbors = num_neighbors
    end

    def is_alive?
      @num_neighbors > 1 && @num_neighbors < 4
    end

    def valid_num_of_neighbors?
      raise TooFewNeighborsError if @num_neighbors < 0
      raise TooManyNeighborsError if @num_neighbors > 8
    end
  end

  it 'is dead if there is zero neighbors' do
    alive = Cell.new(0).is_alive?
    expect(alive).to be false
  end

  it 'is dead if there is one neighbor' do
    alive = Cell.new(1).is_alive?
    expect(alive).to be false
  end

  it 'is alive if there is two neighbors' do
    alive = Cell.new(2).is_alive?
    expect(alive).to be true
  end

  it 'is dead if there are more than three neighbors' do
    alive = Cell.new(4).is_alive?
    expect(alive).to be false

    alive = Cell.new(5).is_alive?
    expect(alive).to be false

    alive = Cell.new(6).is_alive?
    expect(alive).to be false
  end

  it 'raises an exception if there are less than 0 neighbors' do
    expect{Cell.new(-1).valid_num_of_neighbors?}.to raise_error TooFewNeighborsError
    expect{Cell.new(0).valid_num_of_neighbors?}.not_to raise_error
  end

  it 'raises an exception if there are more than 8 neighbors' do
    expect{Cell.new(100).valid_num_of_neighbors?}.to raise_error TooManyNeighborsError
    expect{Cell.new(8).valid_num_of_neighbors?}.not_to raise_error
  end
end
