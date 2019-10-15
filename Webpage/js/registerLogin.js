

function onLogin() {
	var password, email, data;

	password = document.getElementById('passwordLogin');
	email = document.getElementById('emailLogin');
	
	data = {
		"password": password.value,
		"email": email.value
	}
	console.log(data);
	$.ajax({
		url: url + port + "/user/login", 					// Request URL							
		type: "post",
		data: data,
		success: function (data)   	//  function called when succeded
		{
			
			console.log('loggedIn');
			console.log(data);
			jwt = data.token;
			jwtString = "Bearer " + jwt;
			document.cookie = "jwt=" + jwtString;
			window.location.href = 'Homepage.html';
			getAllItems();
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler');
		}
	});

}

function onRegister() {
	console.log('register');
	var password, email, name, data;

	password = document.getElementById('passwordRegister');
	email = document.getElementById('emailRegister');
	name = document.getElementById('nameRegister');

	var data = {
		"name": name.value,
		"email": email.value,
		"password": password.value
	}

	$.ajax({
		url: url + port + "/user/signup", 					// Request URL							
		type: "post",
		data: data,
		success: function (data)   	//  function called when succeded
		{
			console.log('Register Success');
			console.log(data);
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler');
		}
	});
}