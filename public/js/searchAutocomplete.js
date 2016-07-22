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

			auto.hgjghjgjhgjhg = ["Pikachu", "Vulpix"];

			// loop through auto.hgjghjgjhgjhg (el)
			// 	create new DOM node in 'auto'
			// 		make that node a DIV
			// 		into that div, place 'el'


		auto.addEventListener("click", function(){
			// var text = document.getElementById("test");

			search.value = "banana";

		});

	});
});