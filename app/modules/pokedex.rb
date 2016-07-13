
class Pokedex

# Write record to pokedex.csv files
	def Pokedex.pokedex_write_record(new_pokemon)
		
	
		require 'csv'

		new_pokemon = ["Josh", 28, 11, "Grass"]

		CSV.open('pokedex.csv', 'w') do |csv|
			csv << new_pokemon
		end
	end


#Read all record in pokedex.csv and put into file.
	def Pokedex.pokedex_all_records()
		require 'csv'
		list = Array.new
		file = 'pokedex.csv'

		CSV.foreach(file) do |record|

			list << record
			p list
			return list
		end
	end


end
