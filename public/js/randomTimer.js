window.addEventListener("load", function(){

	function refreshStats (){

	var runFunction = new XMLHttpRequest();


  	function runFunction (){
    	var stat = document.getElementsByClassName("stats__info");
    	for (i = 0; i < stat.length; i++){
    		// stat[i].innerHTML = e.target.responseText;
    	}
    }

		runFunction.open ("get", "http://localhost:9292", true);
		runFunction.send();

		setTimeout(refreshStats, 2000);

	};

});