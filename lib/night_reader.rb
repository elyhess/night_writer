require_relative './reader'

read_file = File.read(ARGV[0].chomp)
night_reader = Writer.new(read_file, ARGV[1])
night_reader.export