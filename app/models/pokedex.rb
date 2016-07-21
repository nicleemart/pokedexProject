#pokedex.csv file format  name,height,weight,gender,type,cp,hp,
#favorite,evolution1,evolution2,evolution3
require "httparty"
require "pry"



# @evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@id}")


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


	def Pokeapi.api_evolution_array(pokemon_info)


		firstevolution = pokemon_info["chain"]["species"]["name"]
		secevolution = pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		thirdevolution = pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		evolutionarray =[]


		
		if firstevolution.is_a?  String
			evolutionarray << firstevolution
		end

		if secevolution.is_a? String
			evolutionarray << secevolution
		else
			evolutionarray << "None"
		end

		if thirdevolution.is_a? String
			evolutionarray << thirdevolution
		else
			evolutionarray << "None"
		end

		return evolutionarray

	end
end





