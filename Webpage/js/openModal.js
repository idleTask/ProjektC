	function openModal(n) 
    {
        var image = document.getElementById("bigImage");
        document.getElementById("myModal").style.display = "block";
        
        image.src = document.getElementById(n).src;
        console.log(allItems.items);
        var items = allItems.items;
        $('#itemTitle').text(items[n].title);
        if (items[n].description != null) {
        $('#itemDescription').text(items[n].description);
        } else {
            $('#itemDescription').text("Description");
        }

    }
  
    function closeModal() 
    {
        document.getElementById("myModal").style.display = "none";
    }
