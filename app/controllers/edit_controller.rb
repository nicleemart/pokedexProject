MyApp.get "/edit" do 


	@name = params[:name]
	@pokedex_array = Pokedex.pokedex_all_records()
	@found_array = Pokedex.pokedex_find_record(@name,@pokedex_array)

	if @found_array != false

			@height = @found_array[1]
			@weight = @found_array[2]
			@gender = @found_array[3]
			@type = @found_array[4]
			@cp = @found_array[5]
			@hp = @found_array[6]
			@favorite = @found_array[7]
	else
		@title = "No Pokemon Found"
	end

	
	erb :"pokedex/edit"
end