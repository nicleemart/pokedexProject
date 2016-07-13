require 'test_helper'

class PokedexTest < Minitest::Test

	def test_favorite_pokemon

		all_records = Pokedex.pokedex_all_records
		favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records)

		assert_equal(3, favorite_pokemon.count)
	end

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
		assert_equal(5, test_array.count)

	end


end
