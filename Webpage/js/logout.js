
function onLogout() {
	document.cookie = "jwt = ";
	window.location.href = 'Homepage.html';
}