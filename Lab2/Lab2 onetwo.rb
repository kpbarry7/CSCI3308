# Part1: Hello World
class HelloWorldClass
    def initialize(name)
       @name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!"
    end
end
hello = HelloWorldClass.new("Kevin")
hello.sayHi

# Part2: Palindromes/Counting
def palindrome?(string)
string = string.downcase.gsub(/\W/,'')
string == string.reverse
end
puts palindrome?("A man, a plan, a canal -- Panama")
puts palindrome?("Madam, I'm Adam!")
puts palindrome?("Abracadabra")

def count_words(string)
counts = Hash.new(0)
new_string = string.split(/\W+/)
new_string.each do |word|
new_word = word.gsub(/\W/, '').downcase
counts[new_word] = counts[new_word] + 1
end
counts.delete('')
return counts
end
puts count_words("A man, a plan, a canal -- Panama")
