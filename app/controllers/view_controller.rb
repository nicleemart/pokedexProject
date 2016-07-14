MyApp.get "/view" do 


	
	@name = params[:name]
	@height = params[:height]
	@weight = params[:weight]
	@gender = params[:gender]
	@type = params[:type]
	@cp = params[:cp]
	@hp = params[:hp]
	


	if @height != ""
	

	@new_pokemonarray = []
	@new_pokemonarray << @name
	@new_pokemonarray << @height
	@new_pokemonarray << @weight
	@new_pokemonarray << @gender
	@new_pokemonarray << @type
	@new_pokemonarray << @cp
	@new_pokemonarray << @hp

	Pokedex.pokedex_save_record(@new_pokemonarray)

	end

	erb :"pokedex/view"
end