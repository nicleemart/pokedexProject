require 'csv'

#This method saves a new Pokemon's information in a text file as an Array
#new_pokemon = the Array of traits gathered from the user (via form)
def save_pokemon(new_pokemon)
	#Open the file the new data will be saved in
	CSV.open("pokedex.csv", "a") do |csv|
		#Add the Array to the file
		csv << new_pokemon
	end
end
