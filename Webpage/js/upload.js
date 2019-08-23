// Image Upload Request Function
var url = "http://192.168.10.10";
var port = 3000;
var allItems;

function onUploadSubmit() {
	console.log('upload');
	$("#message").empty();
	$('#loading').show();
	var title = $('#title').prop('value');
	var description = $('#description').prop('value');
	var x = document.cookie;
	var jwtString = getCookie('jwt');

	var formData = new FormData();
	formData.append('title', title);
	formData.append('description', description);
	formData.append('itemImage', $('#file')[0].files[0]);
	$.ajax({
		url: url + ":" + port + "/items", 					// Request URL							//!! Fehlt noch !!
		type: "POST",             	// Request Type	
		data: formData, 	// Data
		contentType: false,       	// Content     
		processData: false,
		headers: {
			"Authorization": jwtString,
		},
		success: function (data)   	//  function called when succeded
		{
			console.log('success');
			$('#loading').hide();
			$("#message").html(data);
			window.location.href = 'Homepage.html';
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler');
			window.location.href = 'Register-loginpage.html';
		}
	});
}

// Preview Image Function
function onFileChange() {
	$("#message").empty(); // Error Message verhindern
	var file = this.files[0];
	var imagefile = file.type;
	var match = ["image/jpeg", "image/png", "image/jpg"];
	if (!((imagefile == match[0]) || (imagefile == match[1]) || (imagefile == match[2]))) {
		$('#preview').attr('src', 'noimage.png');
		$("#message").html("<p id='error'>Please Select A valid Image File</p>" + "<h4>Note</h4>" + "<span id='error_message'>Only jpeg, jpg and png Images type allowed</span>");
		return false;
	}
	else {
		var reader = new FileReader();
		reader.onload = imageIsLoaded;
		reader.readAsDataURL(this.files[0]);
	}
}

function imageIsLoaded(e) {
	$("#file").css("color", "green");
	$('#image_preview').css("display", "block");
	$('#preview').attr('src', e.target.result);
	$('#preview').attr('width', '250px');
	$('#preview').attr('height', '230px');
};

function getCookie(cname) {
  var name = cname + "=";
  var decodedCookie = decodeURIComponent(document.cookie);
  var ca = decodedCookie.split(';');
  for(var i = 0; i <ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

function getAllItems() {
	var x = document.cookie;
	var jwtString = getCookie('jwt');

	$.ajax({
		url: url + ":" + port + "/items", 					// Request URL							//!! Fehlt noch !!
		type: "get",
		headers: {
			"Authorization": jwtString,
		},
		success: function (data)   	//  function called when succeded
		{
			console.log('success');
			$('#loading').hide();
			$("#message").html(data);
			displayItems(data);
			allItems = data;
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler');
			// window.location.href = 'Register-loginpage.html';
		}
	});
}

$(document).ready(function () {
	getAllItems();
});

function displayItems(data) {
	var items = data.items;
	items.forEach(function (item, index) {

		var imageSrc = "'" + url + ":" + port + "/" + item.itemImage + "'";

		$('#images').append("<div class=images><img class= 'displayImages' src=" + imageSrc + "onclick='openModal(id)' height='200' width='200' id='" + index + "'></div>")

	});
}

function onLogin() {
	var password, email, data;

	password = document.getElementById('passwordLogin');
	email = document.getElementById('emailLogin');

	data = {
		"password": password.value,
		"email": email.value
	}

	$.ajax({
		url: url + ":" + port + "/user/login", 					// Request URL							//!! Fehlt noch !!
		type: "post",
		data: data,
		success: function (data)   	//  function called when succeded
		{
			console.log('success');
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
		"email":	email.value,
		"password":	password.value
	}

	$.ajax({
		url: url + ":" + port + "/user/signup", 					// Request URL							//!! Fehlt noch !!
		type: "post",
		data: data,
		success: function (data)   	//  function called when succeded
		{
			console.log('success');
			console.log(data);
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler');
		}
	});
}