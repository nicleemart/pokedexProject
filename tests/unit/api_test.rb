# require 'test_helper'

# class APITest < Minitest::Test

	# def setup
	# 	super

	# 	require 'csv'
	# 	@file = 'tests/unit/pokedex.csv'
	# 	new_pokemon = ["ZCharmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire", "BCharmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire","Charmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire","Squirtle,3,4,female,40,32,no,Squirtle,Wartortle,Blastoise,water"]
	# 	CSV.open(@file, "w") do |csv|
			
	# 		new_pokemon.each do |record|  

	# 			csv << record.split(",")
	# 		end

	# 	end
	# end

	# def test_all
	# 	expected_hash = [
	# 		{
	# 			"name" => "ZCharmander",
	# 			"weight" => 5
	# 		},
	# 		{
	# 			"name" => "BCharmander",
	# 			"weight" => 5
	# 		}
	# 	]

	# 	results = Pokedex.all(@file)

	# 	assert_equal(expected_hash, results)
	# end
# end

require "httparty"
require "pry"
require "json"
info = HTTParty.get("http://localhost:9292/api/all_pokemon")

binding.pry

