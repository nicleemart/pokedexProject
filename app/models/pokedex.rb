#pokedex.csv file format  name,height,weight,gender,type,cp,hp,
#favorite,evolution1,evolution2,evolution3


class Pokedex

	#This method saves a new Pokemon's information in a text file as an Array
	#new_pokemon = the Array of traits gathered from the user (via form)
	def Pokedex.pokedex_save_record(new_pokemon)
		require 'csv'
		#Open the file the new data will be saved in
		CSV.open("pokedex.csv", "a") do |csv|
			#Add the Array to the file
			csv << new_pokemon
		end

	end

	def Pokedex.pokedex_find_record(name_pokemon,pokedex_array)

		pokedex_array.each do |record|
			
			if name_pokemon == record[0]
				return record
			end
		end
		return false
	end
	#search_input = params[:search] (whatever text is put into the search box)
	def Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		pokemon_array = Pokedex.pokedex_all_records()
		pokemon_array.each do |pokemon|
			pokemon.each do |trait|
				if trait == search_input
					return pokemon
				end
			end
		end
		return false
	end

	#This method adds all the Pokemon in the Pokedex file to an Array (returns Array)
	def Pokedex.pokedex_all_records()
		require 'csv'
		#Array to add all Pokemon to
		pokemon_array = []
		#Assign the file name to a variable
		file = 'pokedex.csv'
		#For each line (Array) in the Pokedex file
		CSV.foreach(file) do |record|
			#Add each one to the empty Array
			 pokemon_array.push(record)
		end
		#Return Array containing all of the Pokemon from the Pokedex
		return pokemon_array
	end

	#This method adds all "favorite" Pokemon to an Array (returns Array)
	#all_records = Array containing all Pokemon in the Pokedex returned from pokedex_all_records()
	def Pokedex.pokedex_list_of_favorites(all_records)
		#all_records contains complete list of Pokemon as an Array
		all_records = Pokedex.pokedex_all_records
		#Will contain all the favorite Pokemon
		favorite_pokemon = []
		#Iterate through each Pokemon
		all_records.each do |pokemon|
			#Check if the Pokemon is a favorite
			if pokemon[7] == "on"
				#If so then add the Pokemon to Array
				favorite_pokemon.push(pokemon)
			end
		end
		return favorite_pokemon
	end

	def Pokedex.pokedex_random_favorite(favorite_pokemon)
		all_records = Pokedex.pokedex_all_records
		favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records)

		random_favorite = favorite_pokemon.sample
		return random_favorite
	end

	def Pokedex.pokedex_delete_record(all_records,name_pokemon)

		file = 'pokedex.csv'
	
		CSV.open(file, "w") do |csv|

			all_records.each do |record |

				if record[0] != name_pokemon
					csv << record
				end
			end
		end	
	end
	# def Pokedex.pokedex_add_pokemon(pokemon_traits)
	# 	pokemon_traits = 

	# end
end

