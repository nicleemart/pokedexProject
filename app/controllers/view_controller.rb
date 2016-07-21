MyApp.get "/view" do 
require 'active_support/all'



@title="View Your Pok&eacute;mon"

@file = 'Data_File/pokedex.csv'
	
	@name = params[:name].downcase
	@gender = params[:gender]
	@type = ""
	@cp = params[:cp]
	@hp = params[:hp]
	@favorite = params[:favorite]


#Checks if height exist. If height exist means that view page is coming from add pokemon page
#and will need to save record and display the info. 	
	if params[:gender].present? != false

	
	# This contains the API request information using the Pokemon's name
	@pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
	# Assign the Pokemon's ID taken from the @pokemon request
	@pokemon_id = Pokeapi.id(@pokemon)
	# Assign the species URL taken from @pokemon request (needed to find the correct evolution ID)
	@species_url = Pokeapi.species_url(@pokemon)
	# Use the newly found species URL to make another API request
	@species = HTTParty.get(@species_url)
	# Extract the evolution URL from the data in @species
	@evolution_url = Pokeapi.evolution_url(@species)
	# Select only the evolution ID number from the evolution URL!
	@evolution_id = Pokeapi.evolution_id(@evolution_url)
	# Finally use the evolution ID to get the information about the Pokemon's evolution chain
	@evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@evolution_id}")
	@evolution_array = Pokeapi.api_evolution_array(@evolutions)


	@stage1 = @evolution_array[0].capitalize
	@stage2 = @evolution_array[1].capitalize
	@stage3 = @evolution_array[2].capitalize
	@height = Pokeapi.height(@pokemon)
	@weight = Pokeapi.weight(@pokemon)

	@type_array = Pokeapi.types(@pokemon)


	@new_pokemonarray = []
	@new_pokemonarray << @name.capitalize
	@new_pokemonarray << @height
	@new_pokemonarray << @weight
	@new_pokemonarray << @gender
	@new_pokemonarray << @cp
	@new_pokemonarray << @hp
	@new_pokemonarray << @favorite
	@new_pokemonarray << @stage1
	@new_pokemonarray << @stage2
	@new_pokemonarray << @stage3

	# If pokemon have multiple types save to array and type variable. 
	@type_array.each do |record|

		@new_pokemonarray << record

		@type = @type + " " + record

	end

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
			@cp = @found_array[4]
			@hp = @found_array[5]
			@favorite = @found_array[6]
			@stage1 = @found_array[7]
			@stage2 = @found_array[8]
			@stage3 = @found_array[9]

			x = 10
			
			while x <= @found_array.length

				@type = @type + " " + @found_array[x]

				x +=1
			end
		else
			@name = "No Pokemon Found"
		end
	end

	if @favorite == "on"
		@favorite = "yes"
	else
		@favorite = "no"
	end

	erb :"pokedex/view"
end