# This is for getting information about a SINGLE Pokemon
MyApp.get "/api/pokemon/:name" do

	@given_name = params[:name].capitalize
	@file = 'Data_File/pokedex.csv'
	@all_as_arrays = Pokedex.pokedex_all_records(@file)
	@array_hash = Pokedex.change_the_arrays(@all_as_arrays)
	@selected_pokemon = Pokedex.return_specific_hash(@array_hash, @given_name)

	if @selected_pokemon.is_a? Array
		return @selected_pokemon.to_json
	else
		return @selected_pokemon
	end
end

# This is for getting information about a ALL Pokemon
MyApp.get "/api/all_pokemon" do
	@file = 'Data_File/pokedex.csv'
	@all_as_arrays = Pokedex.pokedex_all_records(@file)
	@all = Pokedex.change_the_arrays(@all_as_arrays)
	

	return @all.to_json


end