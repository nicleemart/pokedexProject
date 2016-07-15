MyApp.get "/" do 
	@file = 'Data_File/pokedex.csv'
	@all_pokemon = Pokedex.pokedex_all_records(@file)
	@favorites_list = Pokedex.pokedex_list_of_favorites(@all_pokemon,@file)
	@random_favorite = Pokedex.pokedex_random_favorite(@favorites_list,@file)
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	erb :"pokedex/home"
end

MyApp.get "/searchresults" do
	@file = 'Data_File/pokedex.csv'
	@pokemon_array = Pokedex.pokedex_all_records(@file)
	@search_input = params[:search]
	@search_results = Pokedex.pokedex_find_by_trait(@pokemon_array, @search_input)
	@search_error = "The Pokemon you're searching for does not exist.\n
					Are you sure you spelled things right?\n
					Capitilization matters!"

	erb :"pokedex/search_results"
end

