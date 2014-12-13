def bubble_sort(array)
	new_arr, sorted = array.dup, false

	until sorted
		sorted = true
		(0...new_arr.size - 1).each do |idx|
			if new_arr[idx] > new_arr[idx+1]
				new_arr[idx], new_arr[idx+1] = new_arr[idx+1], new_arr[idx]
				sorted = false
			end
		end
	end

	new_arr
end