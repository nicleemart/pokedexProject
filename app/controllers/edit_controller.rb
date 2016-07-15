MyApp.get "/edit" do 

	@title="Edit Pok&eacute;mon Info"

	@file = 'Data_File/pokedex.csv'
	@name = params[:name]
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

			if @favorite == "on"
				@favorite = "checked"
			else
				@favorite = ""
			end

	else
		@title = "No Pokemon Found"
	end

	
	erb :"pokedex/edit"
end