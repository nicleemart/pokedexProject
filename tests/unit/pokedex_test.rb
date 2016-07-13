require 'test_helper'

class PokedexTest < Minitest::Test

	def test_add_record

		new_pokemon = ["Charmander",5,2,"male","fire",35,30,"yes","Charmander","Charmeleon","Charizard"]

		Pokedex.pokedex_save_record(new_pokemon)
	end
	

	def test_find_record

		pokedex_array = ["Charmander,5,2,male,fire,35,30,yes,Charmander,Charmeleon,Charizard", "Squirtle,3,4,female,water,40,32,no,Squirtle,Wartortle,Blastoise"]
		name_pokemon = "Squirtle"
		name_test = Pokedex.pokedex_find_record(name_pokemon,pokedex_array)


		assert_equal(name_pokemon,name_test[0,8])
	end


	def test_all_records()

		test_array = Pokedex.pokedex_all_records()
		assert_equal(2, test_array.count)

	end
end
