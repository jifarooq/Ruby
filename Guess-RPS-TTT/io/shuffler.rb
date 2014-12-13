def shuffle_file(path)
  shuffled_lines = File.readlines(path).shuffle
  new_name = path.gsub(/.txt/, "-shuffled.txt")
  
  File.open(new_name, "w") do |f|
    shuffled_lines.each { |line| f.puts line }
  end
  
end

if __FILE__ == $PROGRAM_NAME
  shuffle_file("new_file.txt")
end