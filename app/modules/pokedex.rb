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


#Read all record in pokedex.csv and put into file.
	def Pokedex.pokedex_all_records()
		require 'csv'
		list = Array.new
		file = 'pokedex.csv'

		CSV.foreach(file) do |record|

			list << record
			return list
		end
	end
end
