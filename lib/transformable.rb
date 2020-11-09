module Transformable

  def new_line(content, amount)
    if amount == 40 
      content.scan(/.{1,40}/)
    else 
      content.scan(/.{1,80}/).join("\n")
    end 
  end

  def slice_to_pairs(content)
    content.map do |line|
      line.chars.each_slice(2).to_a
    end
  end

  def format(content)
    slice_to_pairs(content).transpose.map do |line|
      line.join
    end
  end

end