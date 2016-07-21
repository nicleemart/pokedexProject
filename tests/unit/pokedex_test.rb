require 'test_helper'

class PokedexTest < Minitest::Test

	def setup
		super

		require 'csv'
		file = 'tests/unit/pokedex.csv'
		new_pokemon = ["ZCharmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard", "BCharmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard","Charmander,5,2,male,fire,35,30,on,Charmander,Charmeleon,Charizard","Squirtle,3,4,female,water,40,32,no,Squirtle,Wartortle,Blastoise"]
		CSV.open(file, "w") do |csv|
			
			new_pokemon.each do |record|  

				csv << record.split(",")
			end

		end
	end

	# def test_species_url
	# 	name = "gloom"
	# 	pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# 	species_url = Pokeapi.species_url(pokemon)
		
	# 	assert_kind_of(String, species_url)
	# 	refute_nil(species_url)
	# end

	# def test_pokemon_id
	# 	name = "gloom"
	# 	pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# 	id = Pokeapi.id(pokemon)

	# 	assert_kind_of(Fixnum, id)
	# 	refute_nil(id)
	# end	

	# def test_abilities_array
	# 	name = "gloom"
	# 	pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# 	ability_array = Pokeapi.ability_names(pokemon)

	# 	assert_kind_of(Array, ability_array)
	# 	refute_nil(ability_array)
	# end

	def test_evolution

	name = "charmander"
	test_array = ["charmander","charmeleon","charizard"]
		# This contains the API request information using the Pokemon's name
	pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# This contains the API information about the Pokemon's abilities
	# ability = HTTParty.get("http://pokeapi.co/api/v2/ability/#{name}")
	# Assign the Pokemon's ID taken from the pokemon request
	pokemon_id = Pokeapi.id(pokemon)
	# Assign the species URL taken from pokemon request (needed to find the correct evolution ID)
	species_url = Pokeapi.species_url(pokemon)
	# Use the newly found species URL to make another API request
	species = HTTParty.get(species_url)
	# Extract the evolution URL from the data in species
	evolution_url = Pokeapi.evolution_url(species)
	# Select only the evolution ID number from the evolution URL!
	evolution_id = Pokeapi.evolution_id(evolution_url)
	# Finally use the evolution ID to get the information about the Pokemon's evolution chain
	evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{evolution_id}")
	evolution_array = Pokeapi.api_evolution_array(evolutions)

	assert_equal(test_array,evolution_array)




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
		
		assert_equal(search_results, [["ZCharmander", "5", "2", "male", "fire", "35", "30", "on", "Charmander", "Charmeleon", "Charizard"], ["BCharmander", "5", "2", "male", "fire", "35", "30", "on", "Charmander", "Charmeleon", "Charizard"], ["Charmander", "5", "2", "male", "fire", "35", "30", "on", "Charmander", "Charmeleon", "Charizard"]])
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
