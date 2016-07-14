MyApp.get "/add" do 

	@new_pokemon = Pokedex.new
	@new_pokemon.name = params[:name]
	@new_pokemon.height = params[:height]
	@new_pokemon.weight = params[:weight]
	@new_pokemon.gender = params[:gender]
	@new_pokemon.type = params[:type]
	@new_pokemon.cp = params[:cp]
	@new_pokemon.hp = params[:hp]
	@new_pokemon.favorite = params[:favorite]

	Pokedex.pokedex_save_record(@new_pokemon)
	erb :"pokedex/add"
end