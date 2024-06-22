numbers_array = gets.chomp.split(' ')

min, max = numbers_array.first.to_i, numbers_array.first.to_i
total = 0
odds, evens = [], []

numbers_array.each do |digit|
  num = digit.to_i
  min = num if num < min
  max = num if num > max

  num.odd? ? odds.push(num) : evens.push(num)

  total += num
end

puts "==========Result=========="
puts "#{total - max} #{total - min}"
puts "min element of integers: #{min}"
puts "max element of integers: #{max}"
puts "odd elements: #{odds}"
puts "even elements: #{evens}"
