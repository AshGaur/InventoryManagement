  function validateAdmin(){
	   if(document.getElementById("us").value.localeCompare(UserString)!=0){
       document.getElementById("alt").innerHTML="Unknown User";
       return false;
       }
       if(document.getElementById("ps").value.localeCompare(Password)!=0){
       document.getElementById("alt").innerHTML="Unknown User";
       return false;
       }
 }