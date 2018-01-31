# Should return the # of living neighbors of cell in location x, y
# in array arr

def num_neighbors(row, col, arr)

  size = arr.size
  num = 0

  north = row+1
  south = row-1
  east = col+1
  west = col-1

  if west == -1 # wrap around
    west = size-1
  end
  if east == size # wrap around
    east = 0
  end
  if north == size # wrap around
    north = 0
  end
  if south == -1 # wrap around
    south = size-1
  end

  if arr[north][col]
    num += 1
  end
  if arr[south][col]
    num += 1
  end
  if arr[row][west]
    num += 1
  end
  if arr[row][east]
    num += 1
  end
  if arr[north][west]
    num += 1
  end
  if arr[north][east]
    num += 1
  end
  if arr[south][west]
    num += 1
  end
  if arr[south][east]
    num += 1
  end

  num

end

# Should perform one iteration of Conway's game of life

def iterate(arr)
  newArr = []
  (0...arr.size).each do |row|
    newArr[row] = []
    (0...arr.size).each do |col|
      num_neighbors = num_neighbors(row,col,arr)
      if arr[row][col]
        if num_neighbors == 2 || num_neighbors == 3
          newArr[row][col] = true
        else
          newArr[row][col] = false
        end
      else
        if num_neighbors == 3
          newArr[row][col] = true
        else
          newArr[row][col] = false
        end
      end
    end
  end
  arr = newArr
end

# Given a pseudorandom number generator, a size, and a percentage
# of cells to be alive, make a size x size array (e.g., a 10 x 10 array
# if size = 10), and randomly assign percent % of them to be living.
# Return the newly created array to the caller.
# THIS METHOD WAS GIVEN IN ASSIGNMENT

def create_arr(prng, size, percent)
  arr = []
  (0...size).each do |row|
    arr[row] = []
    (0...size).each do |col|
      arr[row][col] = prng.rand(101) <= percent
    end
  end
  arr
end

# Print the array to the screen, with x representing a living
# cell and . representing a dead cell.
# Finish the printing with a single line of asterisks, exactly
# as long as the array is wide.
# There is no need to return anything
# Example:
# ...........
# ...........
# ...........
# ...........
# ...........
# ...........
# .........x.
# ........x.x
# .......x..x
# ........xx.
# ...........
# ***********

def print_arr(arr)
  (0...arr.size).each do |row|
    (0...arr.size).each do |col|
      if arr[row][col]
        print "X"
      else
        print "."
      end
    end
    puts
  end
  arr.size.times { print "*" }
  puts
end

# EXECUTION STARTS HERE

raise "Enter integers for size, percentage (1..100), and number of iterations at command line" unless ARGV.count == 3
size, percent, iters = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i

if size <= 0
  puts "Size is not > 0"
  exit
end

if percent < 0 || percent > 100
  puts "Percent is not an integer between 0 and 100"
  exit
end

if iters < 0
  puts "Number of iterations is not an integer that is 0 or greater"
  exit
end
# If size is not >0, inform the user and exit
# If percent is not an integer between 0 and 100, inform the user and exit
# If number of iterations is not an integer that is 0 or greater, inform the user and exit

# Create the array
arr = create_arr(Random.new, size, percent)
print_arr(arr)

# Iterate for _iters_ iterations
iters.times do
  arr = iterate(arr)
  print_arr(arr)
end
