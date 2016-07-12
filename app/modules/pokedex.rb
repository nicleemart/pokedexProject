	require 'csv'

	new_pokemon = ["Josh", 28, 11, "Grass"]

	CSV.open('pokedex.csv', 'w') do |csv|
		csv << new_pokemon
	end



	list = Array.new
		@file = pokedex.csv

		CSV.foreach(@file) do |@record|

			list << @record
	end
