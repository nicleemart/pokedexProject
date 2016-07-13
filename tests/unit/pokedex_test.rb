require_relative '../test_helper'

class PokedexTest < Minitest::Test

	def test_add_record

		new_pokemon = ["Charmander,5,2,male,fire,35,30,yes,Charmander,Charmeleon,Charizard"]
		Pokedex.pokedex_save_record(new_pokemon)
	end
	
end
