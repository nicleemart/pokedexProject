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

			auto.options = ["Pikachu"];
			auto.innerHTML = (auto.options);

		auto.addEventListener("click", function(){
			// var text = document.getElementById("test");

			search.innerHTML = auto.options;

		});

	});
});