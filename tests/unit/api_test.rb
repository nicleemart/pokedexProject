require 'test_helper'

class APITest < Minitest::Test

	def setup
		super

		require 'csv'
		@file = 'tests/unit/pokedex.csv'
		new_pokemon = ["ZCharmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire", "BCharmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire","Charmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire","Squirtle,3,4,female,40,32,no,Squirtle,Wartortle,Blastoise,water"]
		CSV.open(@file, "w") do |csv|
			
			new_pokemon.each do |record|  

				csv << record.split(",")
			end

		end
	end

	def test_all
		expected_hash = [
["ZCharmander", "5", "2", "male", "35", "30", "on", "Charmander", "Charmeleon", "Charizard", "fire"], ["BCharmander", "5", "2", "male", "35", "30", "on", "Charmander", "Charmeleon", "Charizard", "fire"], ["Charmander", "5", "2", "male", "35", "30", "on", "Charmander", "Charmeleon", "Charizard", "fire"], ["Squirtle", "3", "4", "female", "40", "32", "no", "Squirtle", "Wartortle", "Blastoise", "water"]
		]

		results = Pokedex.all(@file)
		

		assert_equal(expected_hash, results)
	end

	def test_conversion
		expected_hash = [
			{"name"=>"ZCharmander", "weight"=>"5", "height"=>"2", "gender"=>"male", "cp"=>"35", "hp"=>"30", "favorite"=>"on", "stage1"=>"Charmander", "stage2"=>"Charmeleon", "stage3"=>"Charizard", "type"=>"fire"},
{"name"=>"BCharmander", "weight"=>"5", "height"=>"2", "gender"=>"male", "cp"=>"35", "hp"=>"30", "favorite"=>"on", "stage1"=>"Charmander", "stage2"=>"Charmeleon", "stage3"=>"Charizard", "type"=>"fire"},
{"name"=>"Charmander", "weight"=>"5", "height"=>"2", "gender"=>"male", "cp"=>"35", "hp"=>"30", "favorite"=>"on", "stage1"=>"Charmander", "stage2"=>"Charmeleon", "stage3"=>"Charizard", "type"=>"fire"},
{"name"=>"Squirtle", "weight"=>"3", "height"=>"4", "gender"=>"female", "cp"=>"40", "hp"=>"32", "favorite"=>"no", "stage1"=>"Squirtle", "stage2"=>"Wartortle", "stage3"=>"Blastoise", "type"=>"water"}
		]
		results = Pokedex.all(@file)
		data_hash = Pokedex.change_the_arrays(results)

		assert_equal(expected_hash, data_hash)
	end
end

