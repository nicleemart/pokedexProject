#pokedex.csv file format  name,height,weight,gender,type,cp,hp,
#favorite,evolution1,evolution2,evolution3
require "httparty"
require "pry"
require "json"




class Pokedex

	def Pokedex.all(file)
		all_as_arrays = Pokedex.pokedex_all_records(file)
		
	end

	# This method adds saved data to hashes to be displayed as JSON
	#
	# all_as_arrays = Pokedex.all(file)
	#
	# RETURNS ARRAY (OF HASHES)
	def Pokedex.change_the_arrays(all_as_arrays)
		new_hash = {}
		new_array = []

			all_as_arrays.each do |pokemon|

				new_hash["name"] = pokemon[0]
				new_hash["height"] = pokemon[1]
				new_hash["weight"] = pokemon[2]
				new_hash["gender"] = pokemon[3]
				new_hash["cp"] = pokemon[4]
				new_hash["hp"] = pokemon[5]
				new_hash["favorite"] = pokemon[6]
				new_hash["stage1"] = pokemon[7]
				new_hash["stage2"] = pokemon[8]
				new_hash["stage3"] = pokemon[9]
				new_hash["type1"] = pokemon[10]
				new_hash["type2"] = pokemon[11]

			  new_array.push(new_hash.dup)
			end	
		return new_array
	end

	# array_hash = Pokedex.change_the_arrays(all_as_arrays)
	# given_name = name passed into url
	def Pokedex.return_specific_hash(array_hash, given_name)
		single_pokemon = []
		array_hash.each do |hsh|
			if hsh["name"] == given_name
				single_pokemon.push(hsh)
			end
		end
		if single_pokemon.empty?
			return "<h1>There is no data for the Pokemon you have requested.</h1>" + "<br>" +

			"<h3>Double check your spelling and try again just in case.</h3>"

		else
			return single_pokemon
		end
	end

	# This method saves a new Pokemon's information in a text file as an Array
	#
	# new_pokemon = the Array of traits gathered from the user (via form)
	#
	# SAVES DATA TO FILE
	def Pokedex.pokedex_save_record(new_pokemon,file)
		require 'csv'
		#Open the file the new data will be saved in
		CSV.open(file, "a") do |csv|
			#Add the Array to the file
			csv << new_pokemon
		end

	end




	def Pokedex.pokedex_find_record(name_pokemon,pokedex_array)

		pokedex_array.each do |record|
			
			if name_pokemon.capitalize == record[0]
				return record

			end
		end
		return false
	end

	# This method searches the Pokedex for any matching words put into the search
	#
	# search_input = params[:search] (whatever text is put into the search box)
	# pokemon_array represents all Pokemon in the Pokedex
	#
	# RETURNS ARRAY
	def Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		results_array = []
		# Iterate over each of the Pokemon in the Pokedex
		pokemon_array.each do |pokemon|
			found = "no"
			# Iterate over each trait of each of those Pokemon
			pokemon.each do |trait| 
				# If any of the traits match the search input
				if trait == search_input && found == "no"
					# Return those Pokemon
					results_array << pokemon
					found = "yes"
				end
			end
		end
		# If there aren't any matches found in the Pokedex then return false
		return results_array
	end

	# This method adds all the Pokemon in the Pokedex file to an Array
	#
	# file = flat storage file
	#
	# RETURNS ARRAY
	def Pokedex.pokedex_all_records(file)
		require 'csv'
		# Array to add all Pokemon to
		pokemon_array = []
		# Assign the file name to a variable
		# For each line (Array) in the Pokedex file
		CSV.foreach(file) do |record|
			# Add each one to the empty Array
			 pokemon_array.push(record)
		end
		# Return Array containing all of the Pokemon from the Pokedex
		return pokemon_array
	end

	# This method adds all "favorite" Pokemon to an Array
	#
	# all_records = Array containing all Pokemon in the Pokedex returned from pokedex_all_records()
	#
	# RETURNS ARRAY
	def Pokedex.pokedex_list_of_favorites(all_records,file)
		# all_records contains complete list of Pokemon as an Array
		# all_records = Pokedex.pokedex_all_records(file)
		# Will contain all the favorite Pokemon
		favorite_pokemon = []
		# Iterate through each Pokemon
		all_records.each do |pokemon|
			# Check if the Pokemon is a favorite
			if pokemon[6] == "on"
				# If so then add the Pokemon to Array
				favorite_pokemon.push(pokemon)
			end
		end
		return favorite_pokemon
	end

	# This method selects a favorite randomly to be displayed on the home page
	#
	# favorite_pokemon = Array of favorited Pokemon returned from pokedex_list_of_favorites
	#
	# RETURNS ARRAY
	def Pokedex.pokedex_random_favorite(favorite_pokemon,file)
		# all_records is the Array of all the Pokemon in the Pokedex
		all_records = Pokedex.pokedex_all_records(file)
		# favorite_pokemon is the Array of favorited Pokemon
		favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records,file)
		# Select a random Pokemon from the favorites Array
		random_favorite = favorite_pokemon.sample
		return random_favorite
	end

	def Pokedex.pokedex_display_type(found_array)

		x = 11
		type = found_array[10]
			
			while x < found_array.length

				type = type + "," + found_array[x]

				x +=1
			end

			return type

	end

	def Pokedex.pokedex_delete_record(all_records,name_pokemon,file)

	
		CSV.open(file, "w") do |csv|

			all_records.each do |record |

				if record[0] != name_pokemon.capitalize
					csv << record
				end
			end
		end	
	end
	
end

class Pokeapi

	# This method selects the Pokemon's species url
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("URL")
	def Pokeapi.species_url(pokemon)
		pokemon["species"]["url"]
	end

	# This method finds the evolution chain url
	#
	# species = the request for Pokemon species information from API
	#
	# RETURNS A STRING (URL)
	def Pokeapi.evolution_url(species)
		species["evolution_chain"]["url"]
	end

	# This method selects the evolution chain id number from the evolution url
	#
	# species = the request for Pokemon species information from API
	#
	# RETURNS A STRING ('INTEGER')
	def Pokeapi.evolution_id(species)
		species2 = species.split("n/")
		id = species2[1].split("/")
		return id.join('')
	end

	# This method selects the Pokemon id number
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS FIXNUM (INTEGER)
	def Pokeapi.id(pokemon)
		pokemon["id"]
	end

	# This method adds the names of a Pokemon's abilities to an Array
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS ARRAY
	def Pokeapi.ability_names(pokemon)
		ability_names = []
		pokemon["abilities"].each do |i|
			ability_names.push(i["ability"]["name"])
		end
		return ability_names
	end



	# This method adds all the types belonging to the Pokemon passed in to an Array
	#
	# pokemon = the API request information for the Pokemon
	#
	# RETURNS ARRAY
	def Pokeapi.types(pokemon)
		pokemon_types = []
		pokemon["types"].each do |i|
			pokemon_types.push(i["type"]["name"].capitalize)
		end
		return pokemon_types
	end

	# types_array = Pokeapi.types(pokemon)
	# def Pokeapi.types_length(types_array)
	# 	if types_array[1] == 1
	# 		types_array[1] == ""
	# 	end
	# 	return types_array
	# end
	# This method selects the Pokemon's height
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("INTEGER")
	def Pokeapi.height(pokemon)
		pokemon["height"]
	end

	# This method selects the Pokemon's weight
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("INTEGER")
	def Pokeapi.weight(pokemon)
		pokemon["weight"]
	end


	# This method returns evolution path of singel pokemon
	#
	# Pokemon_info comes from api request
	#
	# RETURNS ARRAY with String Elements 

	def Pokeapi.api_evolution_array(pokemon_info)


		# firstevolution = pokemon_info["chain"]["species"]["name"]
		# secevolution = pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		# thirdevolution = pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		
		evolutionarray =[]

	
		# Pokemon statement for first evolution
		evolutionarray << pokemon_info["chain"]["species"]["name"]
		


		# If statement to check for nill on second evolution
		if pokemon_info["chain"]["evolves_to"][0] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		else
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		end

		#If Statement to check for nil on third evolution

		if pokemon_info["chain"]["evolves_to"][0] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0] == nil
			evolutionarray << "None"	
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		else
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		end
		

		return evolutionarray

	end


	# This method adds evolution stages to a Hash for API storage
	# 
	# all_pokemon = Pokedex.pokedex_all_records(file)
	#
	# RETURNS A HASH
	def Pokeapi.evolution_hash(all_pokemon)
		evolutions_hash = {}	

			evolutions_hash["stage1"] = all_pokemon[7]
			evolutions_hash["stage2"] = all_pokemon[8]
			evolutions_hash["stage3"] = all_pokemon[9]
		return evolutions_hash
	end

	# This method adds types to a Hash for API storage
	# 
	# types_array = Pokeapi.types(pokemon)
	#
	# RETURNS A HASH
	def Pokeapi.types_hash(types_array)
		types_hash = {}
			types_hash["type1"] = types_array[0]
			types_hash["type2"] = types_array[1]
			types_hash["type3"] = types_array[2]
		return types_hash
	end

	# This method takes the sorted data taken from the API request and puts it into a Hash
	#
	# types_hash = Pokeapi.types_hash(types_array)
	# evolutions_hash = Pokeapi.evolution_hash(evolution_array)
	# ability_hash = Pokeapi.ability_hash(abilities_array)
	# height = Pokeapi.height(pokemon)
	# weight = Pokeapi.weight(pokemon)
	# name = params[:name]
	#
	# RETURNS A HASH
	def Pokeapi.api_data_hash(name, height, weight, ability_hash, types_hash, evolutions_hash)
		data_hash = {}
		
			data_hash["name"] = name
			data_hash["height"] = height
			data_hash["weight"] = weight
			data_hash["types"] = [types_hash]
			data_hash["abilities"] = [ability_hash]
			data_hash["evolutions"] = [evolutions_hash]

		return data_hash
	end
end

