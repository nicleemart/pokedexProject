MyApp.get "/" do 
	@all_pokemon = Pokedex.pokedex_all_records()
	@favorites_list = Pokedex.pokedex_list_of_favorites(@all_pokemon)
	@random_favorite = Pokedex.pokedex_random_favorite(@favorites_list)
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	erb :"pokedex/home"
end

MyApp.get "/viewall" do
	@pokemon_array = Pokedex.pokedex_all_records()
	@search_input = params[:search]
	@search_results = Pokedex.pokedex_find_by_trait(@pokemon_array, @search_input)
	@search_error = "The Pokemon you're searching for does not exist.\n
					Are you sure you spelled things right?\n
					Capitilization matters!"

	# if @search_results == false
	# 	@search_results = @search_error
	# end

	erb :"pokedex/viewall"
end