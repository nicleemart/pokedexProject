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

			index = record.index(',')
			name_array = record[0,index]

			if name_pokemon == name_array
				return record
			end
		end
		return false
	end

	def Pokedex.pokedex_all_records()
		require 'csv'
		pokemon_array = []
		file = 'pokedex.csv'
		CSV.foreach(file) do |record|

			 pokemon_array.push(record)
		end
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
			if pokemon[7] == "yes"
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
end

