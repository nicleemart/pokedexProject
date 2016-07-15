MyApp.get "/searchresults" do
	@title = "Pok&eacute;mon Search Results"
	@file = 'Data_File/pokedex.csv'
	@pokemon_array = Pokedex.pokedex_all_records(@file)
	@search_input = params[:search]
	@search_results = Pokedex.pokedex_find_by_trait(@pokemon_array, @search_input)
	@search_error = "The Pokemon you're searching for does not exist.\n
					Are you sure you spelled things right?\n
					Capitilization matters!"

	@search_results.each do |pokemon|
		if pokemon[7] == "on"
			pokemon[7] = "yes"

		else
			pokemon[7] = "no"
		end
	end

	erb :"pokedex/search_results"
end