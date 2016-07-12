

	list = Array.new
	@file = pokedex.csv

	CSV.foreach(@file) do | @record |

		list << @record
	end


	
