MyApp.get "/view" do 

<<<<<<< HEAD
	
	@name = params[:name]
	@height = params[:height]
	@weight = params[:weight]
	@gender = params[:gender]
	@type = params[:type]
	@cp = params[:cp]
	@hp = params[:hp]
	
	
=======
	name = params[:name]
	height = params[:height]
	gender = params[:gender]
	type = params[:type]
	cp = params[:cp]
	hp = params[:hp]
	favorite = params[:favorite]

	puts name
>>>>>>> ae497e62c3c76af08aa980be3e891cadc3ad489f

	if @height != ""
	
<<<<<<< HEAD
	@new_pokemonarray = []
	@new_pokemonarray << @name
	@new_pokemonarray << @height
	@new_pokemonarray << @weight
	@new_pokemonarray << @gender
	@new_pokemonarray << @type
	@new_pokemonarray << @cp
	@new_pokemonarray << @hp

	Pokedex.pokedex_save_record(@new_pokemonarray)
=======
	new_pokemonarray = []
	new_pokemonarray << name
	new_pokemonarray << height
	new_pokemonarray << gender
	new_pokemonarray << type
	new_pokemonarray << cp
	new_pokemonarray << hp
	new_pokemonarray << favorite

	Pokedex.pokedex_save_record(new_pokemonarray)
>>>>>>> ae497e62c3c76af08aa980be3e891cadc3ad489f
	end





	erb :"pokedex/view"
end