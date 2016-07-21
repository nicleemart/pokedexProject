window.addEventListener("load", function(){

	var button = document.getElementById("button");

	button.addEventListener("click", function(){

		var evolutionImages = document.getElementsByClassName("banana");

		for (var i = 0; i < evolutionImages.length; i++){			
			if (evolutionImages[i].style.display === "none"){
				evolutionImages[i].style.display = "block";
			}

			else {
				evolutionImages[i].style.display = "none";
			}
		}
	});

});