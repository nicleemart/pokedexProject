MyApp.get "/view" do 
require 'active_support/all'
@file = 'Data_File/pokedex.csv'
	
	@name = params[:name]
	@height = params[:height]
	@weight = params[:weight]
	@gender = params[:gender]
	@type = params[:type]
	@cp = params[:cp]
	@hp = params[:hp]
	@favorite = params[:favorite]

	

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
	@new_pokemonarray << @favorite

	@pokedex_array = Pokedex.pokedex_all_records(@file)
	Pokedex.pokedex_delete_record(@pokedex_array,@name,@file)
	Pokedex.pokedex_save_record(@new_pokemonarray,@file)


#Check if name params is present and displays the pokemon stats. 
	elsif params[:name].present? != false


		@pokedex_array = Pokedex.pokedex_all_records(@file)
		
		@found_array = Pokedex.pokedex_find_record(@name,@pokedex_array)

		if @found_array != false

			@height = @found_array[1]
			@weight = @found_array[2]
			@gender = @found_array[3]
			@type = @found_array[4]
			@cp = @found_array[5]
			@hp = @found_array[6]
			@favorite = @found_array[7]
		end
	else
			@name = "No Pokemon Found"
	end

	if @favorite == "on"
		@favorite = "yes"
	else
		@favorite = "no"
	end

	erb :"pokedex/view"
end