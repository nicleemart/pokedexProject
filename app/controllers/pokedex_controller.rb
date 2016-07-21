MyApp.get "/" do

	@title="Personal Pok&eacute;dex"

	@file = 'Data_File/pokedex.csv'
	@all_pokemon = Pokedex.pokedex_all_records(@file)
	@favorites_list = Pokedex.pokedex_list_of_favorites(@all_pokemon,@file)
	@random_favorite = Pokedex.pokedex_random_favorite(@favorites_list,@file)
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"

	if @random_favorite[6] == "on"
		@random_favorite[6] = "yes"
	else
		@random_favorite[6] = "no"
	end
	erb :"pokedex/home"

	
end