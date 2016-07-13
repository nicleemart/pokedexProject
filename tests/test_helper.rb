ENV['RACK_ENV'] = 'test'
require 'simplecov'
SimpleCov.start do
  add_filter "/main.rb"
end

require 'minitest/autorun'
require 'rack/test'

require 'tilt/erb'

class Minitest::Test
  include Rack::Test::Methods
end

require File.expand_path '../../main.rb', __FILE__

require 'csv'
		

		new_pokemon = ["Charmander,5,2,male,fire,35,30,yes,Charmander,Charmeleon,Charizard", "Charmander,5,2,male,fire,35,30,yes,Charmander,Charmeleon,Charizard","Charmander,5,2,male,fire,35,30,yes,Charmander,Charmeleon,Charizard","Squirtle,3,4,female,water,40,32,no,Squirtle,Wartortle,Blastoise"]
		CSV.open("pokedex.csv", "w") do |csv|
			
			new_pokemon.each do |record|  

				csv << record.split(",")
			end

		end