window.addEventListener("load", function(){

	var search = document.getElementById("search");

	search.addEventListener("keyup", function(){

		var auto = document.getElementById("autocomplete");

			if (auto.style.display === "none"){
				auto.style.display = "block";
			}
			else {
				auto.style.display = "none";
			}

	});
});