MyApp.get "/viewall" do 
	@title = "View All of Your Pok&eacute;mon"
	@file = 'Data_File/pokedex.csv'
	@all_pokemon = Pokedex.pokedex_all_records(@file)
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	erb :"pokedex/view_all"
end