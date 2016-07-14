MyApp.get "/edit" do 
	@pokedex_array = Pokedex.pokedex_all_records()
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	if @pokedex_array.empty? == true
		return @no_pokemon_error
	end
	erb :"pokedex/edit"
end