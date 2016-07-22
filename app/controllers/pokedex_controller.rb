MyApp.get "/" do

	@title="Personal Pok&eacute;dex"

	@file = 'Data_File/pokedex.csv'
	@all_pokemon = Pokedex.pokedex_all_records(@file)
	@favorites_list = Pokedex.pokedex_list_of_favorites(@all_pokemon,@file)
	@random_favorite = Pokedex.pokedex_random_favorite(@favorites_list,@file)
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	
	@name = @random_favorite[0]
	@height = @random_favorite[1].to_f / 10
	@weight = @random_favorite[2].to_i / 4.54
	@weight = @weight.round(2)
	@gender = @random_favorite[3]
	@cp = @random_favorite[4]
	@hp = @random_favorite[5]
	@favorite = @random_favorite[6]
	@stage1 = @random_favorite[7]
	@stage2 = @random_favorite[8]
	@stage3 = @random_favorite[9]
	@type = Pokedex.pokedex_display_type(@random_favorite)

	if @favorite == "on"
		@favorite = "yes"
	else
		@favorite = "no"
	end
	erb :"pokedex/home"

	
end