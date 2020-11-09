require_relative './reader'

read_file = File.readlines(ARGV[0].chomp)
night_reader = Reader.new(read_file, ARGV[1])
night_reader.export