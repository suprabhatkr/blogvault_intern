# number operations
puts 10 * 2
puts 500 / 100
puts 1 + 2 + 3 + 4 + 5

#variables
age = 32
puts age
puts age * 10

age = 32
multiplier = 10
total = age * multiplier
puts total

#exercise
orange = 300
apple = 120
total = orange * apple
puts ("total = "+total.to_s+"\n\n")

#String, Arrays and hashes
puts "bacon"
food = "bacon"
puts food
puts "size"
puts "bacon".size
puts "string in uppercase"
puts "bacon".upcase
puts "replacing acon with inary"
puts "bacon".gsub("acon", "inary")
puts "printing each chars"
puts "bacon".chars

puts "Hello There!"
puts "1" + "1"
puts "1".to_i
puts "1 to string"+1.to_s

age = 20
name = "David"
puts "Hello #{name}, our records tell us that you're #{age} years old!"

puts "\nnumber array"
num_arr = [1, 2, 3, 4, 5]
print "#{num_arr}\n"

puts "letter array"
letters = ['a', 'b', 'c']
print "#{letters}\n"
puts "letters [0]"
puts letters[0]
puts "letters [1]"
puts letters[1]
puts "letter [2]"
puts letters[2]
puts "letter [4] (out of reach)"
puts letters[4]
puts "size of array"
puts letters.size

puts "\ninserting array"
numbers = []
numbers << 1
numbers << 2
numbers << 3
print "#{numbers}\n"

puts "\ndictionaries"
ip_to_domain = { "rubyguides.com" => "185.14.187.159"}
print "#{ip_to_domain}\n"
puts ("ip_to_domain[\"rubyguides.com\"] = "+ip_to_domain["rubyguides.com"])
"updating data"
ip_to_domain["rubyguides.com"] = "8.8.8.8"
print "#{ip_to_domain}\n"

values = { "a" => 1, "b" => 2 }
print "values = #{values}\n"

puts "\nexercise"
food = Array["bacon", "orange", "apple"]
print (food)
puts "\n"
puts "printing first element of array"
puts food[0]
puts "printing last element of array"
puts food[-1]
puts "after adding new element \"yogurt\""
food.append("yogurt")
print food
puts "\n\n"
puts "creating a hash of cuntry code to country"
new_hash = {"ES"=>'Spain',"US"=>"United States of America","IN"=>"India"}
print new_hash
puts "\n\n"
puts ("data type of 1 = "+1.class.to_s)
puts ("data type of \"1\" = "+"1".class.to_s)
puts ("adding 1 with 1 = "+(1+1).to_s)
puts ("adding \"1\" with \"1\" = "+("1"+"1"))

#Conditionals in ruby
puts "\nif statement in ruby"
stock = 10
if stock < 1
  puts "Sorry we are out of stock!"
end

puts "\nunless in ruby like !condition"
unless stock<1
  puts "We have stocks"
end

puts "\nif else in ruby"
if stock < 1
  puts "Sorry we are out of stock!"
else
  puts "Thanks for your order!"
end

puts "\nelsif in ruby"
if stock < 1
  puts "Sorry we are out of stock!"
elsif stock == 10
  puts "You get a special discount!"
else
  puts "Thanks for your order!"
end

puts "\nmultiple conditions using and"
name="David"
country = "UK"
age = 20
if name == "David" && country == "UK"
  puts "name is #{name} and country is #{country}"
end

puts "\nmultiple condition using or"
if age == 10 || age == 20
  puts "The age is #{age}"
end

puts "\ncomparing two string"
name  = "David"
expected_name = "david"
if name == expected_name
  puts "string #{name} and #{expected_name} is same"
else
  puts "string #{name} and #{expected_name} are not same"
end

puts "\ncomapring two name by downcasing"
if expected_name.downcase == name.downcase
  puts "Name is correct! #{name} and #{expected_name} is same name"
end

puts "\nspecial character in string"
puts "Enter a string"
name = gets
puts "string with new line"
p name
puts "Enter a string"
name = gets.chomp
puts "string without new line"
p name

puts "\nif construct in one line"
puts "yes" if 2.even?
puts "\nternary conditional operator"
puts 40 > 100 ? "Greater than" : "Less than"

#LOOPS
numbers = [1, 3, 5, 7]
print "\nArray = #{numbers}\n"
puts "iterating through numbers array"
numbers.each { |n| puts }

puts "\niterating through hash"
hash = { bacon: 300, coconut: 200 }
print "hash = #{hash}\n"
hash.each { |key,value| puts "#{key} price is #{value}" }

puts "\niterating array with index"
animals = ["cat", "dog", "tiger"]
print "animals = #{animals}\n"
animals.each_with_index { |animal, idx| puts "We have a #{animal} with index #{idx}" }

puts "\niterating 10 times using times"
10.times { puts "hello" }
10.times { |i| puts "hello #{i}" }

puts "\niterating using each in range of 1 to 10"
(1..10).each { |i| puts i }

puts "\niterating 10 times using while"
n = 0
while n < 10
  puts n
  n += 1
end

puts "\niterating using until where we print till we get 10"
bottle = 0
until bottle == 10
  puts "bottle = #{bottle}"
  bottle += 1
end

puts "\nskipping using next and using condition unless\nprinting only evens"
10.times do |i|
  next unless i.even?
  puts "hello #{i}"
end

puts "\nselecting evens in range of 0 to 9"
puts (0...10).select(&:even?)

puts "\niterating array using each"
numbers = [1,2,4,9,12]
print "#{numbers}\n"
numbers.each do |n|
  break if n > 10
  puts n
end

puts "\niterating from 1 to 5 using upto"
1.upto(5) { |i| puts i }

puts "\nusing class method to find the datatype"
puts "apple".class
puts "\nusing split method to split the string using some token"
puts "a-b-c".split("-")

puts "\ndeclaring a basic class"
class Book1
end
book = Book1.new
puts "class of book = #{book.class}"

puts "\ncalling a class method"
class Book2
  def what_am_i
    puts "I'm a book!"
  end
end
book = Book2.new
book.what_am_i

puts "\ndeclaring data attributes inside class"
class Book3
  def initialize(title, author)
    @title  = title
    @author = author
  end
end
deep_dive = Book3.new("Ruby Deep Dive", "Jesus Castello")
fun = Book3.new("Fun With Programming", "White Cat")
puts "accessing data of class from outside without attribute reader"
begin
  puts deep_dive.title
rescue => r
  puts r
end

class Book4
  attr_reader :title, :author
  def initialize(title, author)
    @title  = title
    @author = author
  end
end
deep_dive = Book4.new("Ruby Deep Dive", "Jesus Castello")
fun = Book4.new("Fun With Programming", "White Cat")
puts "accessing data after using attribute reader"
begin
  puts deep_dive.author
rescue => r
  puts r
end

puts "\nupdating attributes without using attribute_writer"
begin
  deep_dive.title = "Ruby"
rescue => r
  puts r
end

puts "\ndeclaring a class method and calling it without object"
class Food
  def self.cook
    puts "cooking...."
  end
end
Food.cook
puts "Math.sqrt is a class method"
Math.sqrt(25)

puts "\nexercise"
class Cat
  def meow
    puts "I'm a cat, gimme food & pet me now!"
  end
end
rusty = Cat.new
3.times do
  rusty.meow
end