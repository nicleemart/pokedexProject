MyApp.get "/viewall" do 
	@all_pokemon = Pokedex.pokedex_all_records

	erb :"pokedex/view_all"
end