require 'test_helper'

class PokedexTest < Minitest::Test

	def setup
		super

		require 'csv'
		file = 'tests/unit/pokedex.csv'
		new_pokemon = ["Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard", "Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard","Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard","Squirtle,3,4,female,water,40,32,no,Squirtle,Wartortle,Blastoise"]
		CSV.open(file, "w") do |csv|
			
			new_pokemon.each do |record|  

				csv << record.split(",")
			end

		end
	end


	def test_favorite_pokemon

		file = 'tests/unit/pokedex.csv'
		all_records = Pokedex.pokedex_all_records(file)
		favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records,file)

		assert_equal(3, favorite_pokemon.count)
	end

	def test_add_record

		file = 'tests/unit/pokedex.csv'
		new_pokemon = ["Charmander",5,2,"male","fire",35,30,"on","Charmander","Charmeleon","Charizard"]

		Pokedex.pokedex_save_record(new_pokemon,file)

		test_array = Pokedex.pokedex_all_records(file)

		assert_equal(5,test_array.count)


	end
	

	def test_find_record

		file = 'tests/unit/pokedex.csv'

		pokedex_array = Pokedex.pokedex_all_records(file)
		name_pokemon = "Charmander"
		name_test = Pokedex.pokedex_find_record(name_pokemon,pokedex_array)


		assert_equal(name_pokemon,name_test[0])

	end


	def test_all_records()
		file = 'tests/unit/pokedex.csv'
		test_array = Pokedex.pokedex_all_records(file)
		assert_equal(4, test_array.count)

	end

	def test_search_name
		file = 'tests/unit/pokedex.csv'
		pokemon_array = Pokedex.pokedex_all_records(file)
		search_input = "Squirtle"
		search_results = Pokedex.pokedex_find_record(search_input,pokemon_array)
		
		assert_equal(search_results, ["Squirtle", "3", "4", "female", "water", "40", "32", "no", "Squirtle", "Wartortle", "Blastoise"])
		
	end

	def test_search_type
		file = 'tests/unit/pokedex.csv'
		pokemon_array = Pokedex.pokedex_all_records(file)
		search_input = "fire"
		search_results = Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		
		assert_equal(search_results, [["Charmander", "5", "2", "male", "fire", "35", "30", "on", "Charmander", "Charmeleon", "Charizard"], ["Charmander", "5", "2", "male", "fire", "35", "30", "on", "Charmander", "Charmeleon", "Charizard"], ["Charmander", "5", "2", "male", "fire", "35", "30", "on", "Charmander", "Charmeleon", "Charizard"]])
	end

	def test_delete_record()

		file = 'tests/unit/pokedex.csv'

		name_pokemon = "Squirtle"

		all_records = Pokedex.pokedex_all_records(file)

		Pokedex.pokedex_delete_record(all_records,name_pokemon,file)

		all_records = Pokedex.pokedex_all_records(file)

		assert_equal(3,all_records.count)

	end


end
