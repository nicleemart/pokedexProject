# # This is for getting information about a SINGLE Pokemon
# MyApp.get "/api/pokemon/:name" do
# 	@pokemon_data = # Method that fills flat storage data into API data shell (Hash and Arrays)

# 	return @pokemon_data # somehow convert the data to JSON
# end

# This is for getting information about a ALL Pokemon
MyApp.get "/api/all_pokemon" do
	@file = 'Data_File/pokedex.csv'
	@all_as_arrays = Pokedex.pokedex_all_records(@file)
	@all = Pokedex.change_the_arrays(@all_as_arrays)
	

	return @all.to_json


end