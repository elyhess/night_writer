require_relative './writer'

read_file = File.read(ARGV[0].chomp)
night_writer = Writer.new(read_file, ARGV[1])
night_writer.export