class Cave
  attr_reader :water, :previous_square

  def initialize(file)
    @cave = []
    @water = nil
    @flow_positions = [[1,0]]

    File.open(file, "r") do |f|
      @water = f.readline.to_i
      f.readline
      f.each_line do |line|
        @cave << line.chomp.chars
      end
    end
  end

  ######## Le Broken Version ##########
  def fill #(row, col)
    p @flow_positions
    position = @flow_positions.shift
    row = row(position)
    column = column(position)

    if empty_space_below?(position)
      @cave[row+1][column] = "~"
      @flow_positions << [row+1, column]
      # @flow_positions << [row, column + 1]
      true
    elsif empty_space_to_the_right?(position)
      @cave[row][column+1] = "~"
      @flow_positions << [row, column+1]
      # @flow_positions << position
      true
    end
  end

####### Le Recursive Version ##########
# def fill(row, col)
#   square = @cave[row][col]
#   if square == "#"
#     false
#   elsif square == " "
#     @cave[row][col] = "~"
#   else
#     fill(row+1, col) || fill(row, col+1)
#   end
# end

  def row(position)
    position[0]
  end

  def column(position)
    position[1]
  end

  def empty_space_below?(position)
    @cave[position[0]+1][position[1]] == " "
  end

  def empty_space_to_the_right?(position)
    @cave[position[0]][position[1]+1] == " "
  end

  def first_empty_square_in_a_row(row)
    @cave[row].index(" ")
  end

  def to_s
    @cave.map { |row| row.join }.join("\n")
  end
end

cave = Cave.new(ARGV[0])

cave.water.times do
  # cave.fill(1,0) # recursive version
  cave.fill
  puts cave
end