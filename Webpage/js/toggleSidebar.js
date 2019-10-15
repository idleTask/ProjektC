var baropen = 0;
function togglebar() {
if(document.getElementById("sidebar").style.display == "none") {
openbar();
}
else {
closebar();
}
}



function openbar() {
baropen =1;
  document.getElementById("sidebar").style.display = "block";
  

}

function closebar() {
baropen = 0;
  document.getElementById("sidebar").style.display = "none";
  

}