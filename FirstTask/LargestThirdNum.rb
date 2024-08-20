def largest(arr)
size = arr.size

(size-1).times do |i|
  (size-1).times do |j|
    if arr[j] > arr[j+1]
      temp = arr[j]
      arr[j] = arr[j+1]
      arr[j+1] = temp
    end
  end
end

puts arr[size-3]
end
arr = [23, 4, 70,5, 65, 6,80]
largest(arr)