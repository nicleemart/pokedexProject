MyApp.get "/" do 
	@all_pokemon = Pokedex.pokedex_all_records()
	@favorites_list = Pokedex.pokedex_list_of_favorites(@all_pokemon)
	@random_favorite = Pokedex.pokedex_random_favorite(@favorites_list)
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	erb :"pokedex/home"
end