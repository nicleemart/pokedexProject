MyApp.get "/view" do 

	name = params[:name]
	height = params[:height]
	gender = params[:gender]
	type = params[:type]
	cp = params[:cp]
	hp = params[:hp]
	
	puts name

	if height != ""
	
	new_pokemonarray = []
	new_pokemonarray << name
	new_pokemonarray << height
	new_pokemonarray << gender
	new_pokemonarray << type
	new_pokemonarray << cp
	new_pokemonarray << hp

	Pokedex.pokedex_save_record(new_pokemonarray)
	end





	erb :"pokedex/view"
end