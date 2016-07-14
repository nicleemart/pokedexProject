MyApp.get "/viewall" do 
	@all_pokemon = Pokedex.pokedex_all_records
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	erb :"pokedex/view_all"
end