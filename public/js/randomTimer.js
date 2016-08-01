
window.addEventListener("load", function() {

            function refreshStats() {

                var request = new XMLHttpRequest();

                    request.addEventListener("load", function(e) {
                    	debugger;
                            var stat = document.getElementsByClassName("stats__info");
                            for (i = 0; i < stat.length; i++) {
                                stat[i].innerHTML = e.target.responseText[i];
                            }
                        });
                    

                    request.open("get", "/random_favorite", true);
                    request.send();
}
                    setInterval(refreshStats, 7000);

            });