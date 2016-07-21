Pokemon API


			Pokemon

	Access information about a specific Pokemon (name, height, weight, evolutions, type, abilities).

	GET /api/pokemon/{name}
	-------------------------------------------------------------------------------------------------
	Example Response:
	-------------------------------------------------------------------------------------------------
		
		{
			"name": "pikachu",
			"height": 4,
			"weight": 60,
			"types": [{"name": "electric"],
			"abilities": [{"name": }],
			"evolutions": [{"firstStage": "pikachu", "secondStage": "raichu"}]

		}

	-------------------------------------------------------------------------------------------------