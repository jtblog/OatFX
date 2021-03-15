document.addEventListener('DOMContentLoaded', function() {
	//window._service = localStorage["_service"]
	//window.prepare_view();
    window.footer = document.getElementById('copyright');
	window.copyright_text = "© " + new Date().getFullYear() + ', OatGroup. All rights reserved'
    window.footer.innerHTML = copyright_text;
    //$("#send_message_form").submit(function(e){e.preventDefault(); window.send_message();})
});

window.host = window.location.href.slice(0, window.location.href.lastIndexOf("/"));

window.open_login_modal = function(){
    
    if($("#login_btn").html() == "Log In"){
        $("#login_form_modal").modal("show");
    }else{
        window.close_connection()
    }
    
}

window.close_connection = function(){
	endpoint = "close_connection"
    /*var submit_btn = document.getElementById("send");
	submit_btn.disabled = true;
	submit_btn.innerHTML = "Sending"

	window.nameipt = document.getElementById("nameipt");
	window.emailipt = document.getElementById("emailipt");
	window.msgipt = document.getElementById("messageipt");

	var data = JSON.stringify({"name" : nameipt.value, "email" : emailipt.value, "message" : msgipt.value})*/
	var xhr = new XMLHttpRequest();
	xhr.withCredentials = true;

	xhr.addEventListener("readystatechange", function () {
		if (this.readyState === 4) {
			if ( this.status == 200 ) {  
		      	/*submit_btn.disabled = false;
		      	submit_btn.innerHTML = "Send Message";
		      	nameipt.value = "";
		      	emailipt.value = "";
		      	msgipt.value = "";
                $("#contact_modal").modal("hide");
	    		$("#success_modal").modal("show");*/
	      	} else { 
	      		//submit_btn.disabled = false;
		        //submit_btn.innerHTML = "Send Message";
	    		//alert(this.status + ": " + this.responseText);
			} 
		}
	});
	xhr.onerror = function () { 
		/*submit_btn.disabled = false;
        submit_btn.innerHTML = "Send Message";
		console.log(this.status + ": " + this.responseText);*/
		//error(this, this.status); 
	};

	xhr.open("GET", host+endpoint);
	xhr.setRequestHeader("Content-Type", "application/json");
	xhr.setRequestHeader("Accept", "*/*");
	xhr.setRequestHeader("Cache-Control", "no-cache");
	xhr.send(null);
	//xhr.send(data);
}