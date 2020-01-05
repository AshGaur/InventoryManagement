window.onload = function() {
  		document.getElementById("guestem").value='null@invm.com';
	}
	
        function validateForm() 
        {
            var x = document.forms["myForm"]["email"].value;
            var y= document.forms["myForm"]["pass"].value;
            if (x.length==0) 
            {
            document.getElementById("emalert").innerHTML="Email must be entered"; 
            document.getElementById("email").focus();    
            
                return false;
            }
            if(y.length==0)
            {
        document.getElementById("passalert").innerHTML= "Password must be entered";
                document.getElementById("pass").focus();
                return false;
            }
    }
		function enGuest()
		{
			document.getElementById("guestem").value='';
			document.getElementById("guestem").style.display="block";
			document.getElementById("uslogin").style.display="block";
			document.getElementById("guestlogin").style.display="none";
			document.getElementById("email").style.display="none";
			document.getElementById("pass").style.display="none";
			document.getElementById("forg").style.display="none";
			document.getElementById("emalert").style.display="none";
			document.getElementById("passalert").style.display="none";
			document.getElementById("email").value='guest@invm.com';
			document.getElementById("pass").value='guest';
		}