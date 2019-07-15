// Image Upload Request Function
$(document).ready(function (e) {

	$("#uploadimage").on('submit',(function(e) {
	e.preventDefault();
	$("#message").empty();
	$('#loading').show();

		$.ajax({
			url: "", 					// Request URL							//!! Fehlt noch !!
			type: "POST",             	// Request Type	
			data: new FormData(this), 	// Data
			contentType: false,       	// Content type
			cache: false,             	// cache
			processData:false,        	// 
			success: function(data)   	//  function called when succeded
			{
				$('#loading').hide();
				$("#message").html(data);
			}
		});
	}));



// Preview Image Function
	$(function() {
		$("#file").change(function() {
		$("#message").empty(); // Error Message verhindern
		var file = this.files[0];
		var imagefile = file.type;
		var match= ["image/jpeg","image/png","image/jpg"];
		if(!((imagefile==match[0]) || (imagefile==match[1]) || (imagefile==match[2])))
		{
			$('#preview').attr('src','noimage.png');
			$("#message").html("<p id='error'>Please Select A valid Image File</p>"+"<h4>Note</h4>"+"<span id='error_message'>Only jpeg, jpg and png Images type allowed</span>");
			return false;
		}
		else
		{
			var reader = new FileReader();
			reader.onload = imageIsLoaded;
			reader.readAsDataURL(this.files[0]);
		}
		});
});

	function imageIsLoaded(e) {
		$("#file").css("color","green");
		$('#image_preview').css("display", "block");
		$('#preview').attr('src', e.target.result);
		$('#preview').attr('width', '250px');
		$('#preview').attr('height', '230px');
	};
});