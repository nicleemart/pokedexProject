require 'test_helper'

class PokedexTest < Minitest::Test

	def setup
		super

		require 'csv'
		new_pokemon = ["Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard", "Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard","Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard","Squirtle,3,4,female,water,40,32,no,Squirtle,Wartortle,Blastoise"]
		CSV.open("pokedex.csv", "w") do |csv|
			
			new_pokemon.each do |record|  

				csv << record.split(",")
			end

		end
	end


	def test_favorite_pokemon

		all_records = Pokedex.pokedex_all_records
		favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records)

		assert_equal(3, favorite_pokemon.count)
	end

	def test_add_record

		new_pokemon = ["Charmander",5,2,"male","fire",35,30,"on","Charmander","Charmeleon","Charizard"]

		Pokedex.pokedex_save_record(new_pokemon)
	end
	

	def test_find_record

		pokedex_array = Pokedex.pokedex_all_records()
		name_pokemon = "Charmander"
		name_test = Pokedex.pokedex_find_record(name_pokemon,pokedex_array)


		assert_equal(name_pokemon,name_test[0])

	end


	def test_all_records()

		test_array = Pokedex.pokedex_all_records()
		assert_equal(4, test_array.count)

	end

	def test_search_name
		pokemon_array = Pokedex.pokedex_all_records()
		search_input = "Squirtle"
		search_results = Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		
		assert_equal(search_results, ["Squirtle", "3", "4", "female", "water", "40", "32", "no", "Squirtle", "Wartortle", "Blastoise"])
		
	end

	def test_search_type
		pokemon_array = Pokedex.pokedex_all_records()
		search_input = "water"
		search_results = Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		
		assert_equal(search_results, ["Squirtle", "3", "4", "female", "water", "40", "32", "no", "Squirtle", "Wartortle", "Blastoise"])
	end

	def test_delete_record()

		name_pokemon = "Squirtle"

		all_records = Pokedex.pokedex_all_records()

		Pokedex.pokedex_delete_record(all_records,name_pokemon)

		all_records = Pokedex.pokedex_all_records()

		assert_equal(3,all_records.count)

	end


end
