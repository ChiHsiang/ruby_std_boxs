# Read file many times
File.open("lorem.txt") do |file|
  while line = file.gets
    p line
  end
end

# Read file one time
File.read("lorem.txt")

puts "===================="
# Read file to specify byte
File.open("lorem.txt") do |file| 
  p file.binmode
  p file.read(10)
  p file.read(20)
  p file.read(30)
end

