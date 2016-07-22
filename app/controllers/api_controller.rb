# # This is for getting information about a SINGLE Pokemon
# MyApp.get "/api/pokemon/:name" do
# 	@pokemon_data = # Method that fills flat storage data into API data shell (Hash and Arrays)

# 	return @pokemon_data # somehow convert the data to JSON
# end

# This is for getting information about a ALL Pokemon
# MyApp.get "/api/all_pokemon" do
# 	@file = File.open('Data_File/api.json')
# 	# @data_hash = JSON.parse(@file)
# 	return @file
# end