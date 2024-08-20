arr = [2, 5, 3, 4, 6, 7, 8, 4, 3]
occurrences = {}

arr.each do |element|
  if occurrences.key?(element)
    occurrences[element] += 1
  else
    occurrences[element] = 1
  end
end

puts occurrences