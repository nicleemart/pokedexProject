MyApp.get "/view" do 
require 'active_support/all'

@title="View Your Pok&eacute;mon"

@file = 'Data_File/pokedex.csv'
	
	@name = params[:name]
	@gender = params[:gender]
	@type = params[:type]
	@cp = params[:cp]
	@hp = params[:hp]
	@favorite = params[:favorite]
	@stage1 = params[:stage1]
	@stage2 = params[:stage2]
	@stage3 = params[:stage3]
	

#Checks if height exist. If height exist means that view page is coming from add pokemon page
#and will need to save record and display the info. 	
	if params[:gender].present? != false


	@api_hash = Pokedex.pokedex_api_stats(@name)

	@height = @api_hash["height"]
	@weight = @api_hash["weight"]
	
	@new_pokemonarray = []
	@new_pokemonarray << @name.capitalize
	@new_pokemonarray << @height
	@new_pokemonarray << @weight
	@new_pokemonarray << @gender.capitalize
	@new_pokemonarray << @type.capitalize
	@new_pokemonarray << @cp
	@new_pokemonarray << @hp
	@new_pokemonarray << @favorite
	@new_pokemonarray << @stage1.capitalize
	@new_pokemonarray << @stage2.capitalize
	@new_pokemonarray << @stage3.capitalize

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
			@stage1 = @found_array[8]
			@stage2 = @found_array[9]
			@stage3 = @found_array[10]
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