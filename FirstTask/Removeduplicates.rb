def fun(arr)
size = arr.size

(size-1).times do |i|
  (size-1).times do |j|
    if j > i && arr[i] == arr[j]
      arr.delete_at(j)
      j -= 1
    end
  end
end

puts arr
end
arr = [23, 4, 4, 70, 5, 65, 65, 70, 6, 80]
fun(arr)