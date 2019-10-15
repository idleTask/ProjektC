
var url = "https://pi.idletask.de";
var port = "";
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
		url: url + port + "/items", 					// Request URL							
		type: "POST",            	// Request Type	
		data: formData, 	// Data
		contentType: false,       	// Content     
		processData: false,
		headers: {
			"Authorization": jwtString,
		},
		crossDomain: true,
		success: function (data)   	//  function called when succeded
		{
			console.log('upload success');
			$('#loading').hide();
			$("#message").html(data);
			window.location.href = 'Homepage.html';
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log('fehler2');
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
	for (var i = 0; i < ca.length; i++) {
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
		url: url + port + "/items", 					// Request URL							
		type: "get",
		headers: {
			"Authorization": jwtString,
		},
		dataType: 'json',
		success: function (data)   	//  function called when succeded
		{
			console.log('getAllItems');
			$('#loading').hide();
			$("#message").html(data);
			displayItems(data);
			allItems = data;
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log(XMLHttpRequest);
			console.log(errorThrown);
			console.log('fehler2');
			// window.location.href = 'Register-loginpage.html';
		}
	});
}






$(document).ready(function () {
	
	
	getAllItems();
	
	});

function displayItems(data) {

	
	var jwtString = getCookie('jwt');
	var items = data.items;
	items.forEach(function (item, index) {
		$.ajax({
			url: url + port + '/' + item.itemImage, 					// Request URL							
			type: "get",
			contentType: 'image/png',
			headers: {
				"Authorization": jwtString,
			},
			mimeType: "text/plain; charset=x-user-defined",
			success: function (data)   	//  function called when succeded
			{
				console.log('display success');
				var base64Image = base64Encode(data);
				$('#images').append("<div class=images><img class= 'displayImages' src='data:image;base64," + base64Image + "' onclick='openModal(id)' height='200' width='200' id='" + index + "'></div>");
			},
			error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log(XMLHttpRequest);
				console.log(errorThrown);
				console.log('fehler get images');
				// window.location.href = 'Register-loginpage.html';
			}
		});
	});

}

function base64Encode(str) {
	var CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	var out = "", i = 0, len = str.length, c1, c2, c3;
	while (i < len) {
			c1 = str.charCodeAt(i++) & 0xff;
			if (i == len) {
					out += CHARS.charAt(c1 >> 2);
					out += CHARS.charAt((c1 & 0x3) << 4);
					out += "==";
					break;
			}
			c2 = str.charCodeAt(i++);
			if (i == len) {
					out += CHARS.charAt(c1 >> 2);
					out += CHARS.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
					out += CHARS.charAt((c2 & 0xF) << 2);
					out += "=";
					break;
			}
			c3 = str.charCodeAt(i++);
			out += CHARS.charAt(c1 >> 2);
			out += CHARS.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
			out += CHARS.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
			out += CHARS.charAt(c3 & 0x3F);
	}
	return out;
}

