class Cave
  attr_reader :water

  def initialize(file)
    @cave = []
    @water = nil

    File.open(file, "r") do |f|
      @water = f.readline.to_i
      f.readline

      f.each_line do |line|
        @cave << line.chomp.chars
      end
    end
  end

  def fill(row, col)
    square = @cave[row][col]
    if square == "#"
      false
    elsif square == " "
      @cave[row][col] = "~"
      true
    else
      fill(row+1, col) || fill(row, col+1)
    end
  end

  # until @water.empty?
  #   # pop a tilda off of @water
  #   # place the tilda at square [1][1]
  #   # previous square = [1][1]
  #   # check if the square below the previous square is empty
  # end

  # @cave.each do |row|
  #   row.each do |col|
  #     is that square empty?
  #       if yes, fill it with @water
  #     is the square below it empty?
  #       if yes, fill it

  #   end
  # end

  def to_s
    @cave.map { |row| row.join }.join("\n")
  end
end

cave = Cave.new(ARGV[0])

cave.water.times do
  cave.fill(1,0)
  puts cave
end