	function openModal(n) 
    {
        var image = document.getElementById("bigImage");
        document.getElementById("myModal").style.display = "block";
		
        image.src = document.getElementById(n).src;
       
    }
  
    function closeModal() 
    {
        document.getElementById("myModal").style.display = "none";
    }
