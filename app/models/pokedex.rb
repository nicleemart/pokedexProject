#pokedex.csv file format  name,height,weight,gender,type,cp,hp,
#favorite,evolution1,evolution2,evolution3
require "httparty"
require "pry"



	# num = "1"
	# http = "http://pokeapi.co/api/v2/evolution-chain/"
	# http << num
	# pokemon_info = HTTParty.get(http)

	# binding.pry
	





class Pokedex

	#This method saves a new Pokemon's information in a text file as an Array
	#new_pokemon = the Array of traits gathered from the user (via form)
	def Pokedex.pokedex_save_record(new_pokemon,file)
		require 'csv'
		#Open the file the new data will be saved in
		CSV.open(file, "a") do |csv|
			#Add the Array to the file
			csv << new_pokemon
		end

	end

	#Stats in hash as following "id",height,weight"
	def Pokedex.pokedex_api_stats(name)
		http = "http://pokeapi.co/api/v2/pokemon/"
		http << name
		pokemon_info = HTTParty.get(http)


		return pokemon_info
	end



	def Pokedex.pokedex_find_record(name_pokemon,pokedex_array)

		pokedex_array.each do |record|
			
			if name_pokemon == record[0]
				return record
			end
		end
		return false
	end
	#This method searches the Pokedex for any matching words put into the search (returns Array)
	#search_input = params[:search] (whatever text is put into the search box)
	def Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		#pokemon_array represents all Pokemon in the Pokedex
		results_array = []
		#Iterate over each of the Pokemon in the Pokedex
		pokemon_array.each do |pokemon|
			#Iterate over each trait of each of those Pokemon
			pokemon.each do |trait|
				#If any of the traits match the search input
				if trait == search_input
					#Return those Pokemon
					results_array << pokemon
				end
			end
		end
		#If there aren't any matches found in the Pokedex then return false
		return results_array
	end

	#This method adds all the Pokemon in the Pokedex file to an Array (returns Array)
	def Pokedex.pokedex_all_records(file)
		require 'csv'
		#Array to add all Pokemon to
		pokemon_array = []
		#Assign the file name to a variable
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
	def Pokedex.pokedex_list_of_favorites(all_records,file)
		#all_records contains complete list of Pokemon as an Array
		#all_records = Pokedex.pokedex_all_records(file)
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

	#This method selects a favorite randomly to be displayed on the home page (returns Array)
	#favorite_pokemon = Array of favorited Pokemon returned from pokedex_list_of_favorites
	def Pokedex.pokedex_random_favorite(favorite_pokemon,file)
		#all_records is the Array of all the Pokemon in the Pokedex
		all_records = Pokedex.pokedex_all_records(file)
		#favorite_pokemon is the Array of favorited Pokemon
		favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records,file)
		#Select a random Pokemon from the favorites Array
		random_favorite = favorite_pokemon.sample
		return random_favorite
	end

	def Pokedex.pokedex_delete_record(all_records,name_pokemon,file)

	
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

