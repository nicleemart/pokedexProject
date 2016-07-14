MyApp.get "/view" do 
require 'active_support/all'

	
	@name = params[:name]
	@height = params[:height]
	@weight = params[:weight]
	@gender = params[:gender]
	@type = params[:type]
	@cp = params[:cp]
	@hp = params[:hp]
	

#Checks if height exist. If height exist means that view page is coming from add pokemon page
#and will need to save record and display the info. 	
	if params[:height].present? != false
	

	@new_pokemonarray = []
	@new_pokemonarray << @name
	@new_pokemonarray << @height
	@new_pokemonarray << @weight
	@new_pokemonarray << @gender
	@new_pokemonarray << @type
	@new_pokemonarray << @cp
	@new_pokemonarray << @hp

	Pokedex.pokedex_save_record(@new_pokemonarray)

	elsif params[:name].present? != false

		@pokedex_array = Pokedex.pokedex_all_records()
		
		@found_array= Pokedex.pokedex_find_record(@name,@pokedex_array)

		if @found_array != false

			@height = @found_array[1]
			@weight = @found_array[2]
			@gender = @found_array[3]
			@type = @found_array[4]
			@cp = @found_array[5]
			@hp = @found_array[6]
		end
	else
			@name = "No Pokemon Found"
	end




	erb :"pokedex/view"
end