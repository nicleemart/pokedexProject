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

	def Pokedex.pokedex_list_of_favorites(all_records)
		
		favorite_pokemon = []
		all_records.each do |pokemon|
			if pokemon[7] == "yes"
				favorite_pokemon.push(pokemon)
			end
		end
		return favorite_pokemon
	end
end

new_pokemon1 = Pokedex.pokedex_save_record(["Charmander",5,2,"male","fire",35,30,"yes","Charmander","Charmeleon","Charizard"])
new_pokemon2 = Pokedex.pokedex_save_record(["Test",5,2,"male","fire",35,30,"no","Charmander","Charmeleon","Charizard"])
new_pokemon3 = Pokedex.pokedex_save_record(["Blastoise",5,2,"male","water",35,30,"yes","Charmander","Charmeleon","Charizard"])

all_records = Pokedex.pokedex_all_records
favorite_pokemon = Pokedex.pokedex_list_of_favorites(all_records)

puts favorite_pokemon
favorite_pokemon.
