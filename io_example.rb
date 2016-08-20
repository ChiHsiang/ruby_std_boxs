require 'io/console'

rows, columns = $stdout.winsize
puts "Your screen is #{columns} wide and #{rows} tall"

