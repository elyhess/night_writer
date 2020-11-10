require_relative './reader'
# ruby ./lib/night_reader.rb braille.txt original_message.txt
read_file = File.readlines(ARGV[0].chomp)
night_reader = Reader.new(read_file, ARGV[1])
night_reader.export