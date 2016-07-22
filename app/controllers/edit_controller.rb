MyApp.get "/edit" do 

	@title="Edit Pok&eacute;mon Info"

	@file = 'Data_File/pokedex.csv'
	@name = params[:name]
	@pokedex_array = Pokedex.pokedex_all_records(@file)
	@found_array = Pokedex.pokedex_find_record(@name,@pokedex_array)

	if @found_array != false

			@gender = @found_array[3]
			@cp = @found_array[4]
			@hp = @found_array[5]
			@favorite = @found_array[6]

			if @favorite == "on"
				@favorite = "yes"
			else
				@favorite = ""
			end

	else
		@title = "No Pokemon Found"
	end

	
	erb :"pokedex/edit"
end