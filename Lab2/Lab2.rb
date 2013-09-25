# Kevin Barry Lab 2 #

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
puts palindrome?("[1,2,1]")
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

# Part3: RPS
class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def winner?(game)
	return (game[0][1] + game[1][1]) =~ /rs|sp|pr|rr|ss|pp/
end
def rps_game_winner(game)
	rps = ["r","p","s"]
	raise WrongNumberOfPlayersError unless game.length == 2
	if rps.include?(game[0][1].downcase) && rps.include?(game[1][1].downcase)
		if winner?(game)
			game[0]
		else
			game[1]
		end
	else
		raise NoSuchStrategyError
	end
end
 
def rps_tournament_winner(game)
	if game[0][1].class==String
		rps_game_winner(game)
	else
		rps1 =rps_tournament_winner(game[0])
		rps2 =rps_tournament_winner(game[1])
		rps_tournament_winner([rps1, rps2])
	end
end

puts rps_game_winner([["Armando", "P"], ["Dave", "S"]])
puts rps_tournament_winner([[[["Armando", "P"], ["Dave", "S"]], [["Richard", "R"], ["Michael", "S"]]], [[["Allen", "S"], ["Omer", "P"]], [["David E.", "R"], ["Richard X.", "P"]]]])

#Part 4
def combine_anagrams(words)
  words.group_by{|w| w.downcase.chars.sort.to_s}.values
end

puts combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])

#Part 5
class Dessert
attr_accessor :name, :calories
	def initialize(name, calories)
		@name = name
		@calories = calories
	end	
	
	def healthy?
        @calories < 200
    end
    
    def delicious?
        true
    end
end

class JellyBean < Dessert
attr_accessor :flavor
	def initialize(name, calories,flavor)
		@name = name
		@calories = calories
		@flavor = flavor
	end
	
	def delicious?
		flavor != "black licorice"
	end
end

#Part 6
class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attribute's getter
        attr_reader attr_name+"_history" # create bar_history getter
		class_eval %Q{
			def #{attr_name}=(attr_name)
				@attr_name = attr_name                                                         
				if @#{attr_name}_history then
					@#{attr_name}_history << attr_name
				else
					@#{attr_name}_history = Array.new
					@#{attr_name}_history << nil
					@#{attr_name}_history << attr_name
				end                                            
			end
			}
	end
end

class Foo
    attr_accessor_with_history :bar
end

f = Foo.new
f.bar = 1
f.bar = 2
puts f.bar_history.to_s

#Part 7
class Numeric
	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.000}
	def method_missing(method_id)
		singular_currency = method_id.to_s.gsub( /s$/, '')
		if @@currencies.has_key?(singular_currency)
			self / @@currencies[singular_currency]
		else
			super
		end
	end
	
	def in(currency_id)
		singular_currency = currency_id.to_s.gsub( /s$/, '')
		if @@currencies.has_key?(singular_currency)
			self / @@currencies[singular_currency]
		else
			super
		end
	end
end

puts 5.dollars.in(:rupees)

class String
def palindrome?
	return false if self.nil?
		temp = self.gsub(/\W/,'').downcase
		temp = temp.reverse
	end
end

module Enumerable
def palindrome?
	p = to_p
	p = p.reverse
	end
end



#Part 8
class CartesianProduct
    include Enumerable
    def initialize a,b
		@a = a
		@b = b
	end

	def each
		@a.each do |e| 
		@b.each do |f| 
			yield [e,f]
		end
	end
  end
end

c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# Nothing printed since Cartesian product of anything with an empty collection is empty
