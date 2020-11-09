module Transformable

  def slice_to_pairs(content)
    content.map do |line|
      line.chars.each_slice(2).to_a
    end
  end

end