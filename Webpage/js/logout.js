
function onLogout() {
	var data = "";
	
	$.ajax({
		url: url + port + "/user/login", 					// Request URL							
		type: "post",
		data: data,
		success: function ()   	//  function called when succeded
		{
	
			console.log('loggedOut');	
			jwtString = "";
			document.cookie = "" ;
			window.location.href = 'Homepage.html';
			//getAllItems();
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler');
		}






console.log('loggedOut');

window.location.href = 'Homepage.html';
}