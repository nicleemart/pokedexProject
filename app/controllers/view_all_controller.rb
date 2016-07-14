MyApp.get "/viewall" do 
	@all_pokemon = Pokedex.pokedex_all_records
	# if @all_pokemon.empty? == true
	# 	puts "Visit the Add Pokemon page to start building your Pokedex"

	# else
	# 	@all_pokemon
	# end
	erb :"pokedex/view_all"
end