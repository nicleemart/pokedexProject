#pokedex.csv file format  name,height,weight,gender,type,cp,hp,
#favorite,evolution1,evolution2,evolution3
require "httparty"
require "pry"
require "json"



class Pokedex

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
			# Iterate over each trait of each of those Pokemon
			pokemon.each do |trait|
				# If any of the traits match the search input
				if trait == search_input
					# Return those Pokemon
					results_array << pokemon
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


<<<<<<< HEAD
		firstevolution = pokemon_info["chain"]["species"]["name"]
		# secevolution = pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		# thirdevolution = pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
=======
		firstevolution = 
		secevolution = 
		thirdevolution = 
>>>>>>> a282c639ea3079048d0cd989e58d47e75c67d6ca
		evolutionarray =[]


		
		if pokemon_info["chain"]["species"]["name"].is_a?  String
			evolutionarray << pokemon_info["chain"]["species"]["name"]
		end

<<<<<<< HEAD
		# If statement to check for null on second evolution
		if pokemon_info["chain"]["evolves_to"][0] == nil
=======
		if pokemon_info["chain"]["evolves_to"][0]["species"]["name"].is_a? String
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		else
>>>>>>> a282c639ea3079048d0cd989e58d47e75c67d6ca
			evolutionarray << "None"

<<<<<<< HEAD
		elsif pokemon_info["chain"]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		else
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		end

		#If Statement to check for mull on third evolution

		if pokemon_info["chain"]["evolves_to"][0] == nil
			evolutionarray << "None"

		elsif pokemon_info["chain"]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0] == nil
			evolutionarray << "None"	
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		else
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
=======
		if pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"] = nil
			
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		else
			
			evolutionarray[2] << "None"
>>>>>>> a282c639ea3079048d0cd989e58d47e75c67d6ca
		end

		return evolutionarray

	end

	# This method adds abilities to a Hash for API storage
	# 
	# abilities_array = Pokeapi.ability_names(pokemon)
	#
	# RETURNS A HASH
	def Pokeapi.ability_hash(abilities_array)
		ability_hash = {}
			ability_hash["ability1"] = abilities_array[0]
			ability_hash["ability2"] = abilities_array[1]
			ability_hash["ability3"] = abilities_array[2]
		return ability_hash
	end

	# This method adds evolution stages to a Hash for API storage
	# 
	# evolution_array = Pokeapi.api_evolution_array(pokemon_info)
	#
	# RETURNS A HASH
	def Pokeapi.evolution_hash(evolution_array)
		evolutions_hash = {}	
			evolutions_hash["stage1"] = evolution_array[0]
			evolutions_hash["stage2"] = evolution_array[1]
			evolutions_hash["stage3"] = evolution_array[2]
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

	# This method formats the data Hash into JSON
	#
	# data_hash = Pokeapi.api_data_hash(name, height, weight, ability_hash, types_hash, evolutions_hash)
	#
	# RETURNS JSON (HASH)
	def Pokeapi.to_json(data_hash)
		data_hash.to_json
	end

	# This method saves the JSON data to a text file (API)
	#
	# json_data_hash = Pokeapi.to_json(data_hash)
	#
	# SAVES JSON
	def Pokeapi.api_save_hash(json_data_hash)
		
		#Open the file the new data will be saved in
		File.open("Data_File/api.txt", "a") do |apple|
			#Add the Array to the file
			apple << json_data_hash + "\n"
		end
	end

end
<<<<<<< HEAD
=======



>>>>>>> a282c639ea3079048d0cd989e58d47e75c67d6ca
